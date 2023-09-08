# frozen_string_literal: true

class MediaController < ApplicationController
  def index
    @media = Image.safe # TODO: Temporary work with Images only
  end
end
