# frozen_string_literal: true

class MediaAnalyser
  MODERATION_MIN_CONFIDENCE = 60
  DETECT_LABELS_MIN_CONFIDENCE = 75
  MAX_LABELS = 10
  REKOGNITION_TOPIC_ARN = 'arn:aws:sns:eu-west-1:368119411226:AmazonRekognitionTopic'.freeze
  REKOGNITION_ROLE_ARN = 'arn:aws:iam::368119411226:role/AmazonRekognitionVideoRole'.freeze
  JOB_STATUSES ={
    succeeded: 'SUCCEEDED',
    in_progress: 'IN_PROGRESS',
    failed: 'FAILED'
  }.freeze

  class << self
    def unwanted_image?(image_bytes:) # TODO: Handle violent content upload
      client
        .detect_moderation_labels(image: { bytes: image_bytes }, min_confidence: MODERATION_MIN_CONFIDENCE)
        .moderation_labels
        .any?
    end

    def unwanted_video?(job_id:) # TODO: Handle violent content upload
      client
        .get_content_moderation({ job_id: job_id })
        .moderation_labels
        .any?
    end

    def detect_labels(image_bytes:)
      client.detect_labels(image: { bytes: image_bytes }, max_labels: MAX_LABELS, min_confidence: DETECT_LABELS_MIN_CONFIDENCE)
    end

    def get_label_detection(job_id:)
      client.get_label_detection({ job_id: job_id, max_results: MAX_LABELS }).labels
    end

    def start_label_detection(video:)
      client.start_label_detection(
        video: {
          s3_object: {
            bucket: ENV['REKOGNITION_BUCKET'],
            name: video.video.key,
          }
        },
        notification_channel: {
          sns_topic_arn: REKOGNITION_TOPIC_ARN,
          role_arn: REKOGNITION_ROLE_ARN
        },
        min_confidence: DETECT_LABELS_MIN_CONFIDENCE
      )
    end

    def start_content_moderation(video:)
      client.start_content_moderation(
        video: {
          s3_object: {
            bucket: ENV['REKOGNITION_BUCKET'],
            name: video.video.key,
          }
        },
        notification_channel: {
          sns_topic_arn: REKOGNITION_TOPIC_ARN,
          role_arn: REKOGNITION_ROLE_ARN
        },
        min_confidence: MODERATION_MIN_CONFIDENCE
      )
    end

    private

    def client
      @client ||= Aws::Rekognition::Client.new
    end
  end
end
