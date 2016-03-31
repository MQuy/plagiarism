require 'typhoeus'
require 'pragmatic_segmenter'

require 'plagiarism/version'
require 'plagiarism/config'
require 'plagiarism/strategy'

module Plagiarism
  extend self

  def configure
    yield Config
  end

  def unique?(content, params = {})
    Strategy.unique?(content, params)
  end
end
