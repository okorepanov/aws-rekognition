# frozen_string_literal: true

module Media2
  class QuerySearch
    attr_reader :query, :scope

    SEARCH_FIELDS = %w[
      title^2
      description^1
    ].freeze

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
          multi_match: {
            query: query,
            fields: SEARCH_FIELDS,
            fuzziness: "AUTO"
          }
        )
    end
  end
end
