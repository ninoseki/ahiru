# frozen_string_literal: true

module Ahiru
  class Result
    attr_reader :url, :title, :snippet

    def initialize(url:, title:, snippet:)
      @url = url
      @title = title
      @snippet = snippet
    end
  end
end
