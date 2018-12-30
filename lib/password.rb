#!/usr/bin/ruby

require 'digest/md5'
require 'digest/sha2'

def input_password
  puts "Input password."
  @base_password = STDIN.gets.chomp

  if @base_password.nil? || @base_password.empty?
    error "[ERROR] password is empty."
  end

  puts "Entered key: #{@base_password}"

  set_password_values
end

def set_password_values
  @zip_password     = Digest::MD5.hexdigest(@base_password).upcase
  @openssl_password = Digest::SHA256.hexdigest(@base_password).upcase
end
