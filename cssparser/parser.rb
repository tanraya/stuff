require 'rubygems'
require 'sass'

def get_file_as_string(filename)
  data = ''
  File.open(filename, "r").each_line {|line| data += line}
  data
end

engine = Sass::Engine.new(get_file_as_string(File.dirname(__FILE__) + '/style.scss'), :syntax => :scss)
result = engine.to_tree

def cleanup_comment(comment)
  comment.gsub /(\/\*\s*|\s*\*\/)/, ''
end

parsed  = {}
comment = nil

result.each do |node|
  case node
  when Sass::Tree::CommentNode
  	comment = cleanup_comment(node.value.first)
  	parsed[comment] = nil
  when Sass::Tree::RuleNode
  	if comment
  	  parsed[comment] = node.rule.first
  	end
  end
end

parsed.each_pair do |c, tag|
  puts "#{tag} - #{c}"
end
