module Plagiarism
  module Strategies
    class Yahoo < Engine
      URL = 'https://search.yahoo.com/search'

      class << self

        def fetch(content, params)
          Typhoeus.get(URL, params: params.merge(p: content), headers: { 'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36' })
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
