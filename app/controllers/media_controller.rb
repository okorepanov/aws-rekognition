# frozen_string_literal: true

class MediaController < ApplicationController
  def index
    @medias = Media.safe
  end
end
