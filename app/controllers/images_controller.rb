# frozen_string_literal: true

class ImagesController < ApplicationController
  def index
    @images = Image.safe
  end

  def create
    image_bytes = params[:image].read

    if MediaAnalyser.unwanted_image?(image_bytes: image_bytes)
      Rails.logger.info('[ALERT] Violent content')

      redirect_to new_image_path, notice: 'Violent content' # TODO: Better show description about violent content
    else
      @image = Images::Create.call(current_user: current_user, image: params[:image], image_bytes: image_bytes)

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to images_path }
      end
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  def destroy
    @image = Image.find(params[:id])

    @image.destroy!

    Turbo::StreamsChannel.broadcast_remove_to('images', target: @image)
    Turbo::StreamsChannel.broadcast_remove_to('suggested_content', target: @image)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to images_path }
    end
  end
end
