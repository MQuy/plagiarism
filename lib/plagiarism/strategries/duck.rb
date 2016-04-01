module Plagiarism
  module Strategies
    class Duck < Engine
      URL = 'https://duckduckgo.com/html'

      class << self

        def fetch(content, params)
          Typhoeus.get(URL, params: params.merge(q: content))
        end

        def exists?(response)
          doc = Nokogiri::HTML response
          doc.css('.results_links_deep:not(.result--no-result)').all? do |row|
            href = row.at_css('.result__a').attributes['href'].value rescue ''
            uri = URI.parse href
            uri.host =~ whitelists_regex
          end
        end

      end

    end
  end
end
