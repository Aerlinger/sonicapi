module SonicApi
  module File
    def upload(local_file_path)
      payload = { :file => Faraday::UploadIO.new(local_file_path, 'audio/mp3') }

      response = connection.post("/file/upload?access_id=#{@access_id}&format=json", payload)

      @last_upload    = JSON.parse(response.body)

      @last_file_id   = @last_upload["file"]["file_id"]
      @uploads[local_file_path]  = @last_file_id
    end

    def write_csv(filename, csv_data)
      ::File.open(filename, 'w') { |file| file.write(csv_data) }
    end
  end
end
