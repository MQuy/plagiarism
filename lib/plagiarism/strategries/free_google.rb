module Plagiarism
  module Strategies
    class FreeGoogle < Engine
      URL = 'https://ajax.googleapis.com/ajax/services/search/web'
      VERSION = '1.0'

      class << self

        def fetch(content, params)
          Typhoeus.get URL, params: params.merge(v: VERSION, q: content, rsz: :large)
        end

        def iterate(response, action = :all?)
          results = JSON.parse(response)['responseData']['results'] rescue []
          results.send(action) do |r|
            uri = URI.parse URI::encode(r['unescapedUrl'])
            yield uri
          end
        end

      end

    end
  end
end
