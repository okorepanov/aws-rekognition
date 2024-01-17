# frozen_string_literal: true

module Media2
  class QuerySearch
    attr_reader :query, :scope

    BOOST_FIELDS = {
      title: 2,
      description: 1
    }

    def self.call(query:, scope:)
      new(query: query, scope: scope).call
    end

    def initialize(query:, scope:)
      @query = query
      @scope = scope
    end

    def call
      search_result_ids = search_results.pluck(:id)

      scope.where(id: search_result_ids)
    end

    private

    def search_results
      return MediaIndex.all if query.blank?

      MediaIndex
        .query(
          bool: {
            should: [
              labels_search,
              multi_match_search
            ]
          }
        )
    end

    def labels_search
      {
        match: {
          labels: query
        }
      }
    end

    def multi_match_search
      {
        multi_match: {
          query: query,
          fields: BOOST_FIELDS.map { |field, boost| "#{field}^#{boost}" }
        }
      }
    end
  end
end
