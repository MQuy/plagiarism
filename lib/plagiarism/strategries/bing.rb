module Plagiarism
  module Strategies
    class Bing < Engine
      URL = 'https://api.datamarket.azure.com/Bing/SearchWeb/v1/Web'

      class << self

        def fetch(content, params)
          Typhoeus.get(URL, params: params.merge('$format' => :json, 'Query' => "'#{content}'"), userpwd: ":#{Config.bing_key}")
        end

        def iterate(response, action = :all?)
          results = JSON.parse(response)['d']['results'] rescue []
          results.send(action) do |r|
            uri = URI.parse URI::encode(r['Url'])
            yield uri
          end
        end

      end

    end
  end
end
