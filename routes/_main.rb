class Yourender < Sinatra::Base
  get "/" do
    haml :index
  end
end