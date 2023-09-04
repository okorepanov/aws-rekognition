# frozen_string_literal: true

class VideosController < ApplicationController
  def create
    @video = current_user.videos.create!

    @video.video.attach(params[:video])

    job_id = MediaAnalyser.start_content_moderation(video: @video)[:job_id]

    Videos::GetModerationContentWorker.perform_async(job_id, @video.id)

    redirect_to media_path
  end

  def show
    @video = Video.find(params[:id])
  end
end
