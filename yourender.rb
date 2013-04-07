path = File.expand_path '../', __FILE__

require "#{path}/config/env.rb"

class Yourender < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  set :logging, true
  log = File.new "log/development.log", "a"
  STDOUT.reopen log
  STDERR.reopen log

  # partial :comment, { comment: "blah" }
  # partial :comment, comment

  def partial(name, value={})
    locals = if value.is_a? Hash
      value
    else
      hash = {}; hash[name] = value
      hash
    end
    haml "_#{name}".to_sym, locals: locals
  end

  get "/" do
    haml :index
  end

  get "/guide" do
    haml :guide_main
  end

  get "/guides/*" do |name|
    @name = name
    haml :guide
  end

end

# require_all "#{path}/routes"