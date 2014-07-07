require 'rails_helper'

RSpec.describe TrackController, :type => :controller do

  describe "GET 'name:string'" do
    it "returns http success" do
      get 'name:string'
      expect(response).to be_success
    end
  end

  describe "GET 'artist:string'" do
    it "returns http success" do
      get 'artist:string'
      expect(response).to be_success
    end
  end

  describe "GET 'spotify_id:string'" do
    it "returns http success" do
      get 'spotify_id:string'
      expect(response).to be_success
    end
  end

  describe "GET 'order:integer'" do
    it "returns http success" do
      get 'order:integer'
      expect(response).to be_success
    end
  end

  describe "GET 'user_id:integer'" do
    it "returns http success" do
      get 'user_id:integer'
      expect(response).to be_success
    end
  end

  describe "GET 'playlist_id:integer'" do
    it "returns http success" do
      get 'playlist_id:integer'
      expect(response).to be_success
    end
  end

end
