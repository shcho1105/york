class MapsController < ApplicationController
  respond_to :html, :xml, :js
  def index
    if params[:lat]
      lat = params[:lat].to_f
      lon = params[:lon].to_f
      @tweets = Tweet.near(location: [lat, lon]).limit(50)
    else
      @tweets = Tweet.all.limit(100)
    end
    respond_with(@tweets)
  end
end
