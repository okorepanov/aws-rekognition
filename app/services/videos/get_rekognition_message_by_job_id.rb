# frozen_string_literal: true

module Videos
  class GetRekognitionMessageByJobId
    SQS_QUEUE_URL = 'https://sqs.eu-west-1.amazonaws.com/368119411226/AmazonRekognitionQueue'.freeze

    attr_reader :job_id

    def initialize(job_id:)
      @job_id = job_id
    end

    def self.call(job_id:)
      new(job_id: job_id).call
    end

    def call
      while true
        sqs_messages = client.receive_message(queue_url: SQS_QUEUE_URL).messages

        sqs_messages.each do |sqs_message|
          sqs_message_body = JSON.parse(sqs_message.body)
          rekognition_message = JSON.parse(sqs_message_body['Message'])

          next if rekognition_message['JobId'] != job_id
          break if rekognition_message['Status'] == MediaAnalyser::JOB_STATUSES[:in_progress]

          client.delete_message(queue_url: SQS_QUEUE_URL, receipt_handle: sqs_message.receipt_handle)

          return rekognition_message
        end
      end
    end

    private

    def client
      @client ||= Aws::SQS::Client.new
    end
  end
end