# frozen_string_literal: true

class Video < Media
  has_one_attached :video
  has_one_attached :preview_image

  alias_attribute :image, :preview_image
end
