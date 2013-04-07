path = File.expand_path '../../', __FILE__
PATH = path
APP = "yourender"

PRICE = 10 # euro

require "bundler/setup"
Bundler.require :default
module Utils
  def require_all(path)
    Dir.glob("#{path}/**/*.rb") do |model|
      require model
    end
  end
end
include Utils

require "#{path}/lib/translation"
include Translation
require "#{path}/lib/labelize"
include Labelize
require "#{path}/lib/utils"
include Utils
require "#{path}/lib/simple_article_format"


env = ENV["RACK_ENV"] || "development"
# DataMapper.setup :default, "mysql://localhost/yourender_#{env}"
require_all "#{path}/models"
# DataMapper.finalize


# env

DEBUG = true
LANG = "it" # en