# frozen_string_literal: true

class Media < ApplicationRecord
  belongs_to :user

  has_many :media_labels, dependent: :destroy
  has_many :labels, through: :media_labels

  scope :safe, -> { where(safe: true) }

  validates :type, presence: true

  def similar_media
    Media
      .joins(:labels)
      .where(labels: { title: self.labels.pluck(:title) })
      .where.not(id: self.id)
      .group('media.id')
      .order('COUNT(labels.id) DESC')
      .limit(5)
  end
end
