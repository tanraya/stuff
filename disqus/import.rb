require 'rubygems'
require 'bundler/setup'
require 'wp-import-dsl'
require 'nokogiri'
require 'tempfile'
require 'date'

MAPPING = {
  'ruby'       => 'rb',
  'bash'       => 'sh',
  'javascript' => 'js',
  'html'       => 'html',
  'php'        => 'php',
  'sql'        => 'sql',
  'ini'        => 'ini',
  'css'        => 'css',
  nil          => 'plain',
  'nohighlight' => 'plain'
}

def gist(content, class_name)
  content.gsub!('&lt;', '<')
  content.gsub!('&gt;', '>')

  tmpfile = Tempfile.new('gistupload')  
  tmpfile.write(content)
  tmpfile.rewind
 
  class_name = class_name.gsub(/\W+/, '')

  if class_name.size > 0
    if MAPPING[class_name].to_s.size > 0
      class_name = "-t #{MAPPING[class_name]}"
    else
      class_name = "-t #{class_name}"
    end
  end

  #puts class_name

  link = %x{bundle exec gist --no-open #{class_name} < #{tmpfile.path}}
  #link = "http://e1.ru"
  tmpfile.close
  tmpfile.unlink

  link.chop
end

def create_article(title, post_date_gmt, post_name, excerpt, content, tags)
  filename = "#{post_date_gmt.to_date}-#{post_name}.txt"

  File.open("./articles/#{filename}", "w") do |f|
    title.gsub!(/"/, "&quot;")
    f.puts %Q{title: "#{title}"}    

    @tags = []
    tags.each { |tag| @tags << "- #{tag}" unless tag.to_s.match /%/ }

    if @tags.size > 0
      f.puts "tags:"
      f.puts @tags.join("\n")
    end
    
    f.puts ""

    doc = Nokogiri::HTML(content, nil, 'utf-8')
    doc.css("pre code").each do |code|
      link   = gist(code.content, code.attribute('class').to_s)
      script = doc.create_element("script")
      div    = doc.create_element("div")
      script.set_attribute('src', "#{link}.js?file=gistfile1.#{MAPPING[code.attribute('class').to_s]}")
      div.set_attribute('class', "gist")
      div.add_child(script)
      code.parent.replace(div)
    end

    content = doc.css('body').to_html

    if has_excerpt?
      f.puts content.sub '<!--more-->', "\n~"
    else
      f.puts content
    end
  end
end

WpImportDsl.import 'wordpress.2012-02-08.xml' do
  items do
    next unless post? && publish?
    create_article(title, post_date_gmt, post_name, excerpt, content, tags)
  end
end

