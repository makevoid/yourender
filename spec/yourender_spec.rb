require_relative "spec_helper"

describe "Yourender" do
  it "GET /" do
    get "/"
    body.should =~ /Yourender/
  end
end