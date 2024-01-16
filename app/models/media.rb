# frozen_string_literal: true

class Media < ApplicationRecord
  belongs_to :user

  has_many :media_labels, dependent: :destroy
  has_many :labels, through: :media_labels

  scope :safe, -> { where(safe: true) }

  default_scope { safe }

  validates :type, :title, presence: true

  class << self
    def find_by_query(query)
      return all if query.nil?

      where('description LIKE :query or title LIKE :query', query: "%#{query}%")
    end
  end

  def similar_media
    joins(:labels)
      .where(labels: { title: labels.pluck(:title) })
      .where.not(id: id)
      .group('media.id')
      .order('COUNT(labels.id) DESC')
      .limit(5)
  end
end
