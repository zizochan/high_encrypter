#!/usr/bin/ruby

require __dir__ + "/password"
require "pry"
require "fileutils"

def error(message)
  puts message
  exit
end

def execute(command)
  is_success = system(command)

  unless is_success
    error "[ERROR] failed command `#{command}`."
  end
end

def check_file_already_exist(*file_paths)
  file_paths.each do |file_path|
    next unless File.exist?(file_path)

    error "[ERROR] #{file_path} is already exist."
  end
end

def set_file_paths
  @tmp_zip_filename = "tmp.#{@openssl_filename}"
  @tmp_zip_filepath = File.join(@base_dir, @tmp_zip_filename)
  @openssl_filepath = File.join(@base_dir, @openssl_filename)
end

def clean_tmp_zipfile
  unless File.exist?(@tmp_zip_filepath)
    error "[ERROR] #{@tmp_zip_filepath} is not exist."
  end

  FileUtils.rm(@tmp_zip_filepath)
end
