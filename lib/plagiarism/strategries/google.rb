module Plagiarism
  module Strategies
    class Google < Engine
      URL = 'https://www.googleapis.com/customsearch/v1'
      VERSION = '1.0'

      class << self

        def fetch(content, params)
          Typhoeus.get URL, params: params.merge(
            key: Config.google_key,
            cx: Config.google_cx,
            q: content,
            fields: 'items(link)',
            prettyPrint: false
          )
        end

        def iterate(response)
          results = JSON.parse(response)['items'] || []
          results.all? do |r|
            uri = URI.parse URI::encode(r['link'])
            yield uri
          end
        end

      end

    end
  end
end
