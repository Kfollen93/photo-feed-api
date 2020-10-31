class StaticPagesController < ApplicationController
  require 'flickr'
  
  def home
    if params[:user_id]
      flickr = Flickr.new(ENV['FLICKR_API_KEY'], ENV['FLICKR_SHARED_SECRET'])

      @user_id = params[:user_id]
      @profile = flickr.profile.getProfile(:user_id => @user_id)
      @photos = flickr.people.getPhotos(:user_id => @user_id)
      flash.now[:notice] = "User search was successful!"
    end

    rescue Flickr::FailedResponse
    flash.now[:alert] = 'Unable to find User ID!'
  end
end
