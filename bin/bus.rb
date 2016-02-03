#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'curb'
require 'nokogiri'
require 'yaml'
require 'json'
require 'pp'

require_relative 'util.rb'

CONFIG = YAML.load_file(File.expand_path File.dirname(__FILE__) + '/config.yml')

now = Time.new
start_notifications = Time.new(now.year, now.month, now.day, 16, 45, 0, now.utc_offset)
end_notifications = Time.new(now.year, now.month, now.day, 17, 15, 0, now.utc_offset)

previously = {}
if File.exist?(CONFIG['bus_eta']['tempfile'])
  previously = JSON.parse(File.open(CONFIG['bus_eta']['tempfile']).read)
end
previously_dirty = false

cts_response = Curl.post('http://www.corvallistransit.com/rtt/public/RoutePositionET.aspx', {:PlatformTag => "193"})
xml = Nokogiri::XML(cts_response.body_str)
rows = xml.xpath('//table/tbody/tr').collect { |tr| tr.xpath('td').collect { |td| td.text } }
rows.shift
rows.each do |route|
  route_number = route[0]
  route_eta = route[2].to_i

  notification_message = "route #{route_number} will arrive in #{route_eta} " + Util.pluralize(route_eta, 'minute')

  if route_eta <= 10
    next unless (now <=> start_notifications) == 1 && (now <=> end_notifications) == -1

    next if previously.has_key?(route_number)

    pushover = Curl.post('https://api.pushover.net/1/messages.json', {
      :token => CONFIG['bus_eta']['pushover_app_key'],
      :user => CONFIG['global']['pushover_user_key'],
      :message => notification_message,
      :title => "route #{route_number} is almost here",
      :device => CONFIG['bus_eta']['device']
    })
    previously[route_number] = now
    previously_dirty = true
  else
    if previously.has_key?(route_number)
      previously.delete(route_number)
      previously_dirty = true
    end
  end
end

File.open(CONFIG['bus_eta']['tempfile'], 'w').write(JSON.generate(previously)) if previously_dirty
