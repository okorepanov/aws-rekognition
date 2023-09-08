# frozen_string_literal: true

module Images
  class Create
    attr_reader :image, :image_bytes, :current_user

    def initialize(current_user:, image:, image_bytes:)
      @current_user = current_user
      @image = image
      @image_bytes = image_bytes
    end

    def self.call(current_user:, image:, image_bytes:)
      new(current_user: current_user, image: image, image_bytes: image_bytes).call
    end

    def call
      description = Ai::GenerateMediaDescription.call(labels: detected_labels, media_type: 'image')

      image_record = current_user.images.create!(description: description, safe: true, analyzed: true)
      image_record.image.attach(image)

      create_labels(image_record)
      broadcast_image_creation(image_record)

      image_record
    end

    private

    def create_labels(image_record)
      detected_labels.each do |label|
        label = Label.create_or_find_by!(title: label[:name])

        MediaLabel.create!(
          media: image_record,
          label: label,
          confidence: label[:confidence].to_i
        )
      end
    end

    def detected_labels
      @detected_labels ||= MediaAnalyser
                             .detect_labels(image_bytes: image_bytes)
                             .labels
    end

    def broadcast_image_creation(image_record)
      Turbo::StreamsChannel.broadcast_append_to(
        'images',
        target: 'images',
        partial: 'images/image',
        locals: { image: image_record }
      )
    end
  end
end
