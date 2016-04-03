module Plagiarism
  module Strategies
    class Duck < Engine
      URL = 'https://duckduckgo.com/html'

      class << self

        def fetch(content, params)
          Typhoeus.get(URL, params: params.merge(q: content))
        end

        def iterate(response, action = :all?)
          doc = Nokogiri::HTML response
          doc.css('.results_links_deep:not(.result--no-result) .result__a').send(action) do |row|
            href = row.attributes['href'].value rescue ''
            uri = URI.parse URI::encode(href)
            yield uri
          end
        end

      end
    end
  end
end
