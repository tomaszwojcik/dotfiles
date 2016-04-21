#!/usr/bin/env ruby
require 'fileutils'

def git_conflict_line(line)
  line =~ /^(<<<<<<<|=======|>>>>>>>)/
end

xcodeproj_dir = Dir.entries('.').select { |entry| entry =~ /.xcodeproj$/ }.first
unless xcodeproj_dir 
  p 'This script must be run from the XCode project root.'
  exit
end

merged_filepath = "#{xcodeproj_dir}/project.pbxproj.merged"
project_filepath = "#{xcodeproj_dir}/project.pbxproj"

File.open(merged_filepath, 'w') do |w|
  File.open(project_filepath, 'r') do |r|
    r.each_line do |line|
      w.write(line) unless git_conflict_line(line)
    end
  end
end

FileUtils.mv(merged_filepath, project_filepath, force: true)
