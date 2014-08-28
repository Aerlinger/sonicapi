require 'spec_helper'

describe "Live API calls" do
  let!(:api) { SonicApi.authenticate("f63339c9-4bce-4860-8c4e-ca338415e7ce") }

  it "stores the API key" do
    SonicApi.access_id.should eq('f63339c9-4bce-4860-8c4e-ca338415e7ce')
  end

  describe "Uploading a file" do
    let(:file_id) { SonicApi.upload("examples/solo_sax.mp3") }

    it "uploads a file and gets a file_id" do
      expect(file_id).to_not be_empty
    end

    it "can analyze tempo" do
      tempo_response = SonicApi.analyze_tempo(file_id)

      expect(tempo_response["auftakt_result"]).to_not be_nil
      expect(tempo_response["status"]["code"]).to eq 200
    end

    it "can analyze melody" do
      melody_response = SonicApi.analyze_melody(file_id)

      expect(melody_response["melody_result"]).to_not be_nil
      expect(melody_response["status"]["code"]).to eq 200
    end

    it "can analyze loudness"

    it "can analyze key"
  end
end

describe "Conversion" do

end

