#!/usr/bin/ruby

require __dir__ + "/common"

# config
PASSWORD_MIN_LENGTH = 4

# dir exist check
@dir_path = ARGV[0]
if @dir_path.nil?
  error "[USAGE] encrypt.sh DIR_PATH"
end

unless Dir.exist?(@dir_path)
  error "[ERROR] #{@dir_path} is not directory."
end

# input password
input_password
if @base_password.length < PASSWORD_MIN_LENGTH
  error "[ERROR] password is too short."
end

# set values
@base_dir  = File.expand_path(File.dirname(@dir_path))
@base_name = File.basename(@dir_path)
@openssl_filename = "#{@base_name}.enc.zip"

set_file_paths
check_file_already_exist(@tmp_zip_filepath, @openssl_filepath)

# encrypt to zip
execute "cd #{@base_dir} && zip -erq #{@tmp_zip_filename} #{@base_name}/ --password=#{@zip_password}"

# encrypt to openssl enc
execute "cd #{@base_dir} && openssl enc -e -aes256 -in #{@tmp_zip_filename} -out #{@openssl_filename} -pass pass:#{@openssl_password}"

# clean
clean_tmp_zipfile

puts "encrypted to #{@openssl_filepath}."
exit
