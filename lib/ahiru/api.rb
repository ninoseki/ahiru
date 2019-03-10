# frozen_string_literal: true

require "http"
require "oga"

module Ahiru
  class API
    DUCKDUCKGO_ENDPOINT = "https://duckduckgo.com/html/"

    def search(params)
      body = get_body(DUCKDUCKGO_ENDPOINT, params)
      return nil if body.nil?

      Page.new body
    end

    def self.search(params)
      new.search(params)
    end

    private

    def get_body(url, params)
      res = HTTP.get(url, params: params)
      return nil unless res.code == 200

      res.body.to_s
    rescue HTTP::Error, OpenSSL::SSL::SSLError, Addressable::URI::InvalidURIError => _
      nil
    end
  end
end
