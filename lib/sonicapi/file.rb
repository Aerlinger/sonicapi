module SonicApi
  module File
    def upload(file)
      payload = { :file => Faraday::UploadIO.new(file, 'audio/mp3') }

      response = connection.post("/file/upload?access_id=#{@access_key}&format=json", payload)

      @last_upload    = JSON.parse(response.body)

      @last_file_id   = @last_upload["file"]["file_id"]
      @uploads[file]  = @last_file_id
    end
  end
end
