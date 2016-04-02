require 'thor'
require 'yaml'

module Plagiarism
  class Cli < Thor
    include Thor::Actions
    CONFIG_PATH = '~/.plagiarism.yml'

    desc 'init', 'Create file for plagiarism to load config'
    method_option :path, aliases: '-p', desc: 'where put the config', type: :string, default: CONFIG_PATH
    def init
      create_file options[:path], <<-STRING
strategies: "duck, yahoo"
whitelists: "www.ring.md, blog.ring.md"
bing_key: xxx
google_key: xxx
google_cx: xxx
      STRING
    end

    desc 'unique', 'Check the unique content from search engines'
    method_option :content, aliases: '-c', desc: 'content which need to checked', type: :string, required: true
    method_option :path, aliases: '-p', desc: 'where put the config', type: :string, default: CONFIG_PATH
    def unique
      config = YAML.load_file(File.expand_path options[:path])
      Config.strategies = config['strategies'].split(',').map &:strip
      Config.whitelists = config['whitelists'].split(',').map &:strip
      Config.bing_key = config['bing_key']
      Config.google_key = config['google_key']
      Config.google_cx = config['google_cx']

      puts Plagiarism.unique? options[:content]
    end
  end
end
