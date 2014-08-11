require "feedisco/utilities"
require "feedisco/checks"
require "uri"
require "open-uri"

module Feedisco
  module Facebook
    module Page
      extend ::Feedisco::Utilities
      extend ::Feedisco::Checks

      module Discovery
        def find(url, args = {})
          raise ArgumentError.new("url can't be nil!") if url.nil?

          harmonized_url = harmonize_url(url)
          uri = URI.parse(harmonized_url)
          return [] unless uri.hostname == "www.facebook.com"

          feeds = []

          uri.host = "graph.facebook.com"
          open(uri) do |res|
            json = JSON.parse(res.read)
            if _id = json["id"]
              feeds.push "http://www.facebook.com/feeds/page.php?format=rss20&id=" + _id
            end
          end

          feeds
        end
      end
    end
  end
end
