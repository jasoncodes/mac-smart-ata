# -*- coding: utf-8 -*-

require 'rubygems'
require 'bundler'
Bundler.setup

require 'plist'

def field_by_header(header_row, data_row, key)
  pos = header_row.index key
  data_row[pos..-1].split(' ').first
end

profile = Plist::parse_xml(`system_profiler SPSerialATADataType -xml`)

profile.each do |section|
  next unless section['_dataType'] == 'SPSerialATADataType'
  section['_items'].each do |section_item|
    section_item['_items'].each do |item|
      next unless item['bay_name'] && item['bsd_name']

      lines = `smartctl -s on -a #{item['bsd_name']}`.split("\n")
      header = lines.grep(/^ID#/).first
      header_idx = lines.index header
      data = {}
      lines[header_idx+1..-1].each do |row|
        break if row.empty?
        key = field_by_header(header, row, 'ATTRIBUTE_NAME')
        value = field_by_header(header, row, 'RAW_VALUE')
        data[key] = value
      end

      if data.values_at(*%w(Reallocated_Sector_Ct Current_Pending_Sector)).any?
        msg = "#{item['bay_name']} (#{item['bsd_name']}): #{data['Temperature_Celsius']}°C, #{data['Reallocated_Sector_Ct']} sector reallocations"
        if data['Current_Pending_Sector'] && Integer(data['Current_Pending_Sector']) > 0
          msg << " (#{data['Current_Pending_Sector']} pending)"
        end
        puts msg
      end
    end
  end
end
