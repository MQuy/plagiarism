module Plagiarism
  module Config
    extend self

    attr_accessor :threshold

    attr_accessor :strategies
    attr_accessor :whitelists

    attr_accessor :bing_key

    attr_accessor :google_key
    attr_accessor :google_cx
  end
end
