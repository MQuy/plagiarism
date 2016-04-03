module Plagiarism
  module Strategies
    class Yahoo < Engine
      URL = 'https://search.yahoo.com/search'

      class << self

        def fetch(content, params)
          Typhoeus.get(URL, params: params.merge(p: content))
        end

        def iterate(response)
          doc = Nokogiri::HTML response
          doc.css('.searchCenterMiddle li').all? do |row|
            href = row.at_css('.compTitle a').attributes['href'].value rescue ''
            uri = URI.parse URI::encode(href)
            yield uri
          end
        end

      end

    end
  end
end
