require 'rubygems'
require 'bundler/setup'
require 'geoip'
require 'RMagick'

LAT, LON, WIDTH, HEIGHT, BORDER = 180, 360, 2000, 1200, 70

OFFSET_X = (WIDTH.to_f - BORDER.to_f) / LON.to_f
OFFSET_Y = (HEIGHT.to_f - BORDER.to_f) / LAT.to_f

c = Magick::Image.new(WIDTH, HEIGHT, Magick::GradientFill.new(0, 0, HEIGHT, 0, "#24302F", "#1A2423")) do |img|
  #img.background_color = "#1A2423"
end

cache = {}
GeoIP.new(File.dirname(__FILE__) + '/GeoLiteCity.dat').each do |r|
  x = (180.to_f + r.longitude.to_f) * OFFSET_X
  y = (90.to_f - r.latitude.to_f) * OFFSET_Y
  z = x.to_i * y.to_i
  cache[z] ||= 0

  gc = Magick::Draw.new
  gc.fill(cache[z].to_i > 0 ? "#7D762B" : "#EBE3AF") # + ((0xffffff * cache[z].to_i).to_s(16))[0,6]
  gc.point x, y
  gc.draw c

  cache[z] += 1
end

c.write File.dirname(__FILE__) + '/map.png'
