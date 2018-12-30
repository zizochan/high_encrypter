#!/usr/bin/ruby

require __dir__ + "/common"

# config
OUTPUT_DIR_NAME = "_decrypted"

# file exist check
@file_path = ARGV[0]
if @file_path.nil?
  error "[USAGE] decrypt.sh FILE_PATH"
end

unless File.exist?(@file_path)
  error "[ERROR] #{@file_path} is not exist."
end

# input password
input_password

# set values
@base_dir = File.dirname(File.expand_path(@file_path))
@openssl_filename = File.basename(@file_path)

set_file_paths
check_file_already_exist(@tmp_zip_filepath)

# decrypt from openssl enc
execute("cd #{@base_dir} && openssl enc -d -aes256 -in #{@openssl_filename} -out #{@tmp_zip_filename} -pass pass:#{@openssl_password}")

# decrypt from zip
execute "cd #{@base_dir} && unzip -qeP #{@zip_password} -d #{OUTPUT_DIR_NAME} #{@tmp_zip_filepath}"

# clean
clean_tmp_zipfile

puts "decrypted from #{@openssl_filepath}."
exit
