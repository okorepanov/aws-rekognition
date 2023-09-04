# frozen_string_literal: true

module Ai
  class Base
    PROMPT_FILES = {
      media_description_generator: 'lib/ai/prompts/image_rekognition_description.txt.erb'
    }.freeze

    MODELS = {
      completion_model: 'text-davinci-003'
    }.freeze

    def client
      @client ||= OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
    end

    def ai_completion_request
      completion = client.completions(
        parameters: {
          model: model,
          prompt: render_prompt,
          temperature: 0.7,
          max_tokens: 1024,
          top_p: 1
        }
      )

      Rails.logger.info("AI Completion response: #{completion}")

      completion.dig('choices', 0, 'text')
    end

    private

    def render_prompt
      Liquid::Template.parse(prompt).render!(prompt_params)
    end

    def prompt
      File.read(prompt_file)
    end

    def prompt_params
      raise NotImplementedError
    end

    def prompt_file
      raise NotImplementedError
    end

    def model
      raise NotImplementedError
    end
  end
end
