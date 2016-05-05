require 'plagiarism/strategries/engine'
require 'plagiarism/strategries/google'
require 'plagiarism/strategries/bing'
require 'plagiarism/strategries/duck'
require 'plagiarism/strategries/yahoo'

module Plagiarism
  module Strategy
    extend self

    def get(name = :yahoo)
      Strategies.const_get(name.to_s.split('_').map(&:capitalize).join(''))
    end

    def unique?(content, params)
      Config.strategies.all? do |strategy|
        klass = get(strategy)
        klass.new(content, params).unique?
      end
    end

    def match(content, params)
      Config.strategies.find do |strategy|
        klass = get(strategy)
        link = klass.new(content, params).match
        link and return (link == true ? '' : link)
      end
    end
  end
end
