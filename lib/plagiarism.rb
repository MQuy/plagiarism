require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'pragmatic_segmenter'
require 'nokogiri'
require 'json'

require 'plagiarism/version'
require 'plagiarism/config'
require 'plagiarism/strategy'
require 'plagiarism/cli'

module Plagiarism
  extend self

  def configure
    yield Config
  end

  def unique?(content, params = {})
    Strategy.unique?(content, params)
  end
end
