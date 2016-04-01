module Plagiarism
  module Strategies
    class Yahoo < Engine
      URL = 'https://search.yahoo.com/search'

      class << self

        def fetch(content, params)
          Typhoeus.get(URL, params: params.merge(p: content))
        end

        def exists?(response)
          doc = Nokogiri::HTML response
          doc.css('.searchCenterMiddle li').all? do |row|
            href = row.at_css('.compTitle div').content.strip rescue ''
            uri = URI.parse(href =~ /^http/ ? href : 'https://' + href)
            uri.host =~ whitelists_regex
          end
        end

      end

    end
  end
end
