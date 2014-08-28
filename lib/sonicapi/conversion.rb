require 'CSV'

module SonicApi
  module Conversion
    def tempo_to_csv(raw_tempo_json)
      clicks = raw_tempo_json["auftakt_result"]["click_marks"]

      CSV.generate do |csv|
        csv << clicks.first.keys

        clicks.each do |click|
          csv << click.values
        end
      end
    end

    def melody_to_csv(raw_melody_json)
      notes = raw_melody_json["melody_result"]["notes"]

      CSV.generate do |csv|
        csv << notes.first.keys

        notes.each do |note|
          csv << note.values
        end
      end
    end
  end
end
