module Plagiarism
  module Strategies
    class Yahoo < Engine
      URL = 'https://search.yahoo.com/search'

      class << self

        def fetch(content, params)
          Typhoeus.get(URL, params: params.merge(p: content))
        end

        def iterate(response, action = :all?)
          doc = Nokogiri::HTML response
          doc.css('.searchCenterMiddle li .compTitle a').send(action) do |row|
            href = row.attributes['href'].value
            uri = URI.parse URI::encode(href)
            yield uri
          end
        end

      end

    end
  end
end
