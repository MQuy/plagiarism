module Plagiarism
  module Strategies
    class Bing < Engine
      URL = 'https://api.datamarket.azure.com/Bing/SearchWeb/v1/Web'

      class << self

        def fetch(content, params)
          Typhoeus.get(URL, params: params.merge('$format' => :json, 'Query' => content), userpwd: ":#{Config.bing_key}")
        end

        def valid_segments(ps, params)
          ps.segment.count do |sentence|
            typhoeus = fetch("'\"#{sentence}\"'", params)
            json_response = JSON.parse(typhoeus.response_body)
            json_response['d']['results'].blank?
          end
        end

      end

    end
  end
end
