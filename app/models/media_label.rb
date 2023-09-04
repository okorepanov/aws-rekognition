# frozen_string_literal: true

class MediaLabel < ApplicationRecord
  belongs_to :media
  belongs_to :label

  validates :media, :label, :confidence, presence: true
end
