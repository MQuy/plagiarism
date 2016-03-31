module Plagiarism
  module Strategies
    class Google < Engine
      URL = 'https://ajax.googleapis.com/ajax/services/search/web'
      VERSION = '1.0'

      class << self

        def fetch(content, params)
          Typhoeus.get URL, params: params.merge(v: VERSION, q: content)
        end

        def exists?(response)
          response['responseData']['results'].blank?
        end

      end

    end
  end
end
