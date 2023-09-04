# frozen_string_literal: true

module Videos
  class GetDetectedLabelsWorker
    include Sidekiq::Job

    def perform(job_id, video_id)
      rekognition_message = GetRekognitionMessageByJobId.call(job_id: job_id)
      video = Video.find(video_id)

      video.destroy! if rekognition_message['Status'] == MediaAnalyser::JOB_STATUSES[:failed]

      detected_labels = MediaAnalyser.get_label_detection(job_id: job_id)

      Rails.logger.info("Detected Labels: #{detected_labels}")

      ProcessAnalysedVideo.call(video_id: video_id, detected_labels: detected_labels)
    end

    private

    def client
      @client ||= Aws::SQS::Client.new
    end

    def rekognition_client
      @rekognition_client ||= Aws::Rekognition::Client.new
    end
  end
end
