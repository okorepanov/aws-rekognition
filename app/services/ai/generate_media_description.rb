# frozen_string_literal: true

module Ai
  class GenerateMediaDescription < Base
    attr_reader :labels, :media_type

    def initialize(labels:, media_type:)
      @labels = labels
      @media_type = media_type
    end

    def self.call(labels:, media_type:)
      new(labels: labels, media_type: media_type).call
    end

    def call
      ai_completion_request
    end

    private

    def prompt_params
      {
        'rekognition_response' => labels,
        'media_type' => media_type
      }
    end

    def prompt_file
      PROMPT_FILES[:media_description_generator]
    end

    def model
      MODELS[:completion_model]
    end
  end
end
