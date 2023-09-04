# frozen_string_literal: true

module Videos
  class GetModerationContentWorker
    include Sidekiq::Job

    def perform(job_id, video_id)
      rekognition_message = GetRekognitionMessageByJobId.call(job_id: job_id)
      video = Video.find(video_id)

      video.destroy! if rekognition_message['Status'] == MediaAnalyser::JOB_STATUSES[:failed] || MediaAnalyser.unwanted_video?(job_id: job_id)

      label_detection_job_id = MediaAnalyser.start_label_detection(video: video)[:job_id]
      GetDetectedLabelsWorker.perform_async(label_detection_job_id, video.id)
    end
  end
end
