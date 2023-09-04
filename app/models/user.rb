# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  has_many :images
  has_many :videos
end
