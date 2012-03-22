require 'rubygems'
require 'bundler'
Bundler.require

Serious.set :title, 'Neurons To Bytes'
Serious.set :author, 'Tanraya'
Serious.set :url, 'http://torqueo.net'
Serious.set :views, File.join(Dir.getwd, 'views')
Serious.set :items_on_index, 5
Serious.set :archived_on_index, 30

# Make asseps pipeline work
require "sass"
require "sprockets"
require "sprockets-sass"
require "compass"
require "sprockets-helpers"

map "/assets" do
  environment = Sprockets::Environment.new
  environment.append_path "assets/stylesheets"
  environment.append_path "assets/images"
  environment.append_path "assets/javascripts"
  environment.append_path "assets/fonts"
  run environment
end

run Serious
