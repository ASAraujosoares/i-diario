#!/usr/bin/env ruby
require 'openssl'
require 'net/http'
require 'uri'
require 'pg'

puts "=== Audit OpenSSL Migration ==="
puts "Ruby Version: #{RUBY_VERSION}"
puts "OpenSSL Version: #{OpenSSL::OPENSSL_VERSION}"
puts "OpenSSL Library Version: #{OpenSSL::OPENSSL_LIBRARY_VERSION}"

puts "\n--- Checking OpenSSL Algorithms ---"
['MD5', 'SHA1', 'SHA256', 'SHA512', 'RIPEMD160', 'BF', 'CAST', 'RC4'].each do |algo|
  begin
    if ['BF', 'CAST', 'RC4'].include?(algo)
      cipher = OpenSSL::Cipher.new(algo)
      puts "Cipher #{algo}: AVAILABLE"
    else
      digest = OpenSSL::Digest.new(algo)
      puts "Digest #{algo}: AVAILABLE"
    end
  rescue OpenSSL::Cipher::CipherError, RuntimeError => e
    puts "Algorithm #{algo}: NOT AVAILABLE (#{e.class}: #{e.message})"
  end
end

puts "\n--- Checking Connectivity & SSL Context ---"
# Verify if we can create an SSL context with legacy options if needed, or strict
begin
  ctx = OpenSSL::SSL::SSLContext.new
  ctx.min_version = :TLS1_2
  puts "Default SSL Context created successfully (Min TLS 1.2)."
rescue => e
  puts "Error creating SSL Context: #{e.message}"
end

puts "\n--- Checking PG Gem Compatibility ---"
begin
  # Just checking if PG constant exists and library is loaded
  puts "PG Gem Version: #{PG::VERSION}"
  puts "PG Library Version: #{PG.library_version}"
rescue => e
  puts "Error checking PG gem: #{e.message}"
end

puts "\n--- Audit Complete ---"
