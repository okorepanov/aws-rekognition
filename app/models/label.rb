# frozen_string_literal: true

class Label < ApplicationRecord # TODO: fix labels duplications
  has_many :media_labels
  has_many :medias, through: :media_labels

  validates :title, presence: true
end
