require 'faraday'
require 'json'
require 'pp'

ACCESS_ID = "<ACCESS KEY HERE>"

conn = Faraday.new("https://api.sonicapi.com") do |f|
  f.request :multipart
  f.request :url_encoded
  f.adapter :net_http
end

# Upload Local File
payload = { :file => Faraday::UploadIO.new('solo_sax.mp3', 'audio/mp3') }

response = conn.post("/file/upload?access_id=#{ACCESS_ID}&format=json", payload)
puts response.status # Should return 201


# Process Response & store file_id
json_response = JSON.parse(response.body)
file_id = json_response["file"]["file_id"]


response2 = conn.post("/analyze/tempo", access_id: ACCESS_ID, format: 'json', input_file: file_id)

response2.body
