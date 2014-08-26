require "sonicapi/version"

module SonicApi
  class << self
    def authenticate(access_key)
      @access_key = access_key
      @uploads = {}
    end

    def upload(file)
      conn = Faraday.new("https://api.sonicapi.com") do |f|
        f.request :multipart
        f.request :url_encoded
        f.adapter :net_http
      end

      payload = { :file => Faraday::UploadIO.new(file, 'audio/mp3') }

      response = conn.post("/file/upload?access_id=#{@access_key}&format=json", payload)

      @last_upload = JSON.parse(response.body)

      @uploads[file] = @last_upload["file"]["file_id"]
    end

    def analyze_tempo(options = {})

    end

    def analyze_melody(options = {})

    end

    def analyze_loudness(options = {})

    end

    def analyze_key(options = {})

    end
  end
end
