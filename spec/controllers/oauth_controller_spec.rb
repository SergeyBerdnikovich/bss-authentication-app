require 'spec_helper'

describe OauthController do

  describe "GET 'start'" do
    xit "returns http success" do
      get 'start'
      response.should be_success
    end
  end

  describe "GET 'callback'" do
    xit "returns http success" do
      get 'callback'
      response.should be_success
    end
  end

  describe "GET 'get_oauth'" do
    xit "returns http success" do
      get 'get_oauth'
      response.should be_success
    end
  end

end
