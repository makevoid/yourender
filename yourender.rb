path = File.expand_path '../', __FILE__

require "#{path}/config/env.rb"

class Yourender < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  # set :logging, true
  # log = File.new "log/development.log", "a"
  # STDOUT.reopen log
  # STDERR.reopen log

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
    ENV['RACK_ENV'] == "development" ? true : session[:bought]
  end

  # data

  def self.guides
    paths = Dir.glob("guides/*")
    paths.map do |path|
      file  = File.basename path, ".saf"
      split = file.split "_"
      name  = split[1..-1].join("_")
      { name: name, id: split[0].to_i, name_url: file }.to_mhash # guide
    end.sort_by(&:id)
  end

  GUIDES = guides

  class Guide

    def initialize(name_url)
      @name_url = name_url
      @current = GUIDES.find{ |guide| guide.id == get_idx }
    end

    def next
      GUIDES[@current.id+1]
    end

    private

    def get_idx
      @name_url.split("_")[0].to_i
    end

  end

  # paypal

  def buy_link
    "#"
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

  # pages

  get "/contents" do
    haml :contents
  end

  get "/author" do
    haml :author
  end

  get "/examples" do
    haml :examples
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