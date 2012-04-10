require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'tempfile'  

MAPPING = {
  'ruby'       => 'rb',
  'bash'       => 'sh',
  'javascript' => 'js',
  'html'       => 'html',
  'php'        => 'php'
}

source  = "#{File.dirname(__FILE__)}/articles/2011-03-01-rails3-application-templates.txt"
doc     = Nokogiri::HTML(File.open(source).read, nil, 'utf-8')

def gist(content, class_name)
  content.gsub!('&lt;', '<')
  content.gsub!('&gt;', '>')

  tmpfile = Tempfile.new('gistupload')  
  tmpfile.write(content)
  tmpfile.rewind
  system %Q{bundle exec gist --no-open -t #{MAPPING[class_name]} < #{tmpfile.path}}
  tmpfile.close
  tmpfile.unlink
end

doc.css("pre code").each do |code|
  link   = gist(code.content, code.attribute('class').to_s)
  script = doc.create_element("script")
  script.set_attribute('href', link)
  code.replace(script)
end