# frozen_string_literal: true

class MediaIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      html_field: {
        type: 'custom',
        char_filter: ['html_strip'],
        tokenizer: 'standard',
        filter: %w[lowercase trim]
      }
    }
  }

  index_scope Media.safe

  field :id, type: 'integer'
  field :title
  field :description, analyzer: 'html_field'
  field :labels, value: ->(media) { media.labels.pluck(:title) }
end
