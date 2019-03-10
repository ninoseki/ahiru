# frozen_string_literal: true
require "uri"

module Ahiru
  class Page
    DEFAULT_PARAM_KEYS = [:q, :s, :dc].freeze

    def initialize(html)
      @html = html
    end

    def results
      doc.css(".result").map do |result|
        href = result.at_css("a.result__a")&.get("href")
        url = URI.decode_www_form(href).to_h["uddg"]
        title = result.at_css("a.result__a")&.text
        snippet = result.at_css("a.result__snippet")&.text
        Result.new(url: url, title: title, snippet: snippet)
      end
    end

    def next_page
      return nil unless next_page?

      params = doc.css("div.nav-link > form > input[type='hidden']").map do |input|
        key = input.get("name")
        value = input.get("value")
        [key.to_sym, value]
      end.to_h.slice(*DEFAULT_PARAM_KEYS)
      API.search(params)
    end

    def next_page?
      _next_page != nil
    end

    private

    def _next_page
      @_next_page ||= doc.at_css("div.nav-link > form > input[value='Next']")
    end

    def doc
      @doc ||= Oga.parse_html(@html)
    end
  end
end
