path = File.expand_path '../', __FILE__

require "#{path}/config/env.rb"

class Yourender < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  set :logging, true
  log = File.new "log/development.log", "a"
  STDOUT.reopen log
  STDERR.reopen log

  enable :sessions

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

  # helpers: url/classes

  def section
    request.path.split("/")[1]
  end

  def subsection
    request.path.split("/")[2]
  end

  def subpath(level)
    request.path.split("/")[level]
  end

  # helpers: auth

  def requires_login
    unless logged?
      redirect "/login"
    end
  end

  def logged?
    session[:bought]
  end


  # routes: main

  get "/" do
    haml :index
  end

  get "/guide" do
    requires_login
    haml :guide_main
  end

  get "/guides/*" do |name|
    requires_login
    @name = name
    haml :guide
  end

  # routes: auth

  get "/login" do
    haml :login
  end

  get "/buy" do
    haml :buy
  end

  post "/login" do
    session[:bought] = true
    redirect "/guide"
  end

  post "/logout" do
    session[:bought] = nil
    redirect "/"
  end
end

# require_all "#{path}/routes"