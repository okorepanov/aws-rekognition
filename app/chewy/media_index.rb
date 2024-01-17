# frozen_string_literal: true

class MediaIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      email: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      }
    }
  }

  index_scope Media.safe

  field :title
  field :description
end
