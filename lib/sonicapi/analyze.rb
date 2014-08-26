module SonicApi
  module Analyze
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
