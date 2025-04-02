#! /bin/ruby

require "csv"
require "httparty"

csv = CSV.read("claims.csv", headers: true)

csv.each do |row|
  url = row["Attachment"]
  id = row["Claim ID"]

  # download from url and save to file
  response = HTTParty.get(url)
  ext = response.headers["content-type"].split("/").last

  puts "Downloading claim-#{id} ..."
  File.write("downloads/claim-#{id}.#{ext}", response.body)
rescue
  puts "Error downloading #{url}"
  puts row.inspect
end
