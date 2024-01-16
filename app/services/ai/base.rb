# frozen_string_literal: true

module Ai
  class Base
    PROMPT_FILES = {
      media_description_generator: 'lib/ai/prompts/image_rekognition_description.txt.erb'
    }.freeze

    ROLES = {
      user: 'user'
    }.freeze

    MODELS = {
      chat_model: 'gpt-3.5-turbo-1106'
    }.freeze

    def client
      @client ||= OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
    end

    def ai_chat_request
      completion = client.chat(
        parameters: {
          model: model,
          messages: [{ role: ROLES[:user], content: render_message }],
          response_format: { type: 'json_object' },
          temperature: 0.7,
          max_tokens: 1024,
          top_p: 1
        }
      )

      Rails.logger.info("AI Completion response: #{completion}")

      JSON.parse(completion.dig('choices', 0, 'message', 'content'))
    end

    private

    def render_message
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
