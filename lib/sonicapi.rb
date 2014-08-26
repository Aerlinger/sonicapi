require "sonicapi/version"

module SonicApi
  class << self
    def authenticate(access_key)
      @access_key = access_key
      @uploads = {}
    end

    def connection
      @conn ||= Faraday.new("https://api.sonicapi.com") do |f|
        f.request :multipart
        f.request :url_encoded
        f.adapter :net_http
      end
    end

    def upload(file)
      payload = { :file => Faraday::UploadIO.new(file, 'audio/mp3') }

      response = connection.post("/file/upload?access_id=#{@access_key}&format=json", payload)

      @last_upload    = JSON.parse(response.body)

      @last_file_id   = @last_upload["file"]["file_id"]
      @uploads[file]  = @last_file_id
    end

    def analyze_tempo(file_id = nil, options = {})
      analyze(file_id, "tempo", options)
    end

    def analyze_melody(file_id, options = {})
      analyze(file_id, "melody", options)
    end

    def analyze_loudness(file_id, options = {})
      analyze(file_id, "loudness", options)
    end

    def analyze_key(file_id, options = {})
      analyze(file_id, "key", options)
    end

    private

    def analyze(file_id = nil, type = "tempo", options = {})
      file_id ||= @last_file_id

      response = connection.post("/analyze/#{type}", access_id: ACCESS_ID, format: 'json', input_file: file_id)

      response_json = JSON.parse(response.body)

      if block_given?
        yield response_json
      end

      response_json
    end
  end
end
