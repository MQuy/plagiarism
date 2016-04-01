module Plagiarism
  module Strategies
    class Google < Engine
      URL = 'https://ajax.googleapis.com/ajax/services/search/web'
      VERSION = '1.0'

      class << self

        def fetch(content, params)
          Typhoeus.get URL, params: params.merge(v: VERSION, q: content, rsz: :large)
        end

        def exists?(response)
          JSON.parse(response)['responseData']['results'].all? do |r|
            uri = URI.parse(r['unescapedUrl'])
            uri.host =~ whitelists_regex
          end
        end

      end

    end
  end
end
