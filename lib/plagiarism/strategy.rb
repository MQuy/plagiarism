require 'oauth_util'
require 'plagiarism/strategries/engine'
require 'plagiarism/strategries/google'
require 'plagiarism/strategries/bing'

module Plagiarism
  module Strategy
    extend self

    def get(name = :google)
      Strategies.const_get(name.to_s.classify)
    end

    def unique?(content, params)
      Config.strategies.all? do |strategy|
        klass = get(strategy)
        klass.new(content, params).unique?
      end
    end
  end
end
