# frozen_string_literal: true

require "http"
require "oga"
require "uri"

module Ahiru
  class API
    DUCKDUCKGO_ENDPOINT = "https://duckduckgo.com/html/"

    def search(q:, s: nil, dc: nil)
      params = { q: q, s: s, dc: dc }.compact
      body = get_body(DUCKDUCKGO_ENDPOINT, params)
      return nil if body.nil?

      Page.new body
    end

    def self.search(params)
      new.search(params)
    end

    private

    def proxy?
      proxy != nil
    end

    def proxy
      @proxy ||= [].tap do |out|
        https_proxy = ENV["https_proxy"] || ENV["HTTPS_PROXY"]
        out << URI(https_proxy) if https_proxy
      end.first
    end

    def http
      proxy? ? HTTP.via(proxy.host, proxy.port) : HTTP
    end

    def get_body(url, params)
      res = http.get(url, params: params)
      return nil unless res.code == 200

      res.body.to_s
    rescue HTTP::Error, OpenSSL::SSL::SSLError, Addressable::URI::InvalidURIError => _
      nil
    end
  end
end
