# frozen_string_literal: true

class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def create
    image_bytes = params[:image].read

    if MediaAnalyser.unwanted_image?(image_bytes: image_bytes)
      Rails.logger.info('[ALERT] Violent content')

      redirect_to new_image_path, notice: 'Violent content' # TODO: Better show description about violent content
    else
      @image = Images::Create.call(current_user: current_user, image: params[:image], image_bytes: image_bytes)

      redirect_to image_path(@image), notice: 'Image created successfully'
    end
  end

  def show # TODO: show image with it's description and similar images
    @image = Image.find(params[:id])
  end
end
