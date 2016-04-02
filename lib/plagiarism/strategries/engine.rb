module Plagiarism
  module Strategies
    class Engine
      THRESHOLD = 0.8

      attr_accessor :content, :params

      class << self
        def fetch(content, params)
          raise
        end

        def valid_segments(ps, params)
          ps.segment.count do |sentence|
            typhoeus = fetch("\"#{sentence}\"", params)
            typhoeus.success? && exists?(typhoeus.response_body)
          end
        end

        def exists?(response)
          raise
        end

        def whitelists_regex
          whitelists = Config.whitelists.map { |w| Regexp.new w }
          Regexp.union whitelists
        end
      end

      def initialize(c, p)
        @content, @params = c, p
      end

      def unique?
        ps = PragmaticSegmenter::Segmenter.new(text: content)
        valid_segments = self.class.valid_segments(ps, params)
        valid_segments / ps.segment.size >= THRESHOLD
      end
    end
  end
end
