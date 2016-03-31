module Plagiarism
  module Strategies
    class Google < Engine
      URL = 'https://ajax.googleapis.com/ajax/services/search/web'
      VERSION = '1.0'

      class << self

        def fetch(content, params)
          Typhoeus.get URL, params: params.merge(v: VERSION, q: content)
        end

        def valid_segments(ps, params)
          ps.segment.count do |sentence|
            typhoeus = fetch(CGI::escape("\"#{sentence}\""), params)
            json_response = JSON.parse(typhoeus.response_body)
            json_response['responseData']['results'].blank?
          end
        end

      end

    end
  end
end
