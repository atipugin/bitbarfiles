require 'bundler/setup'
require 'nokogiri'
require 'open-uri'
require 'russian'

doc = Nokogiri::XML(open('https://export.yandex.ru/bar/reginfo.xml'))
icons = { 'green' => '😃', 'yellow' => '😕', 'red' => '😡' }
color = doc.at_xpath('/info/traffic/region/icon').content
icon = icons[color]
level = doc.at_xpath('/info/traffic/region/level').content.to_i
level_text = Russian.p(level, 'балл', 'балла', 'баллов')
hint = doc.at_xpath("/info/traffic/region/hint[@lang='ru']").content
url = doc.at_xpath("/info/traffic/region/url").content

puts <<-TXT.strip
#{icon} #{level} #{level_text}|color=#{color}
---
#{hint}|href=#{url}
TXT
