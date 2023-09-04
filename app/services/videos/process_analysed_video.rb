# frozen_string_literal: true

module Videos
  class ProcessAnalysedVideo
    attr_reader :video, :detected_labels

    def initialize(video_id:, detected_labels:)
      @video = Video.find(video_id)
      @detected_labels = detected_labels
    end

    def self.call(video_id:, detected_labels:)
      new(video_id: video_id, detected_labels: detected_labels).call
    end

    def call
      description = ::Ai::GenerateMediaDescription.call(labels: detected_labels, media_type: video.type)

      create_labels(video)

      video.update!(
        description: description,
        analyzed: true,
        safe: true
      )
    end

    private

    def create_labels(video_record)
      detected_labels.each do |label|
        label = Label.create_or_find_by!(title: label.label.name)

        MediaLabel.create!(
          media: video_record,
          label: label,
          confidence: label[:confidence].to_i
        )
      end
    end
  end
end
