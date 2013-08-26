class RsvpsController < ApplicationController

  def new
    @rsvp = Rsvp.new
  end
  
  def create
    @rsvp = Rsvp.new(params[:rsvp])
    if @rsvp.deliver
      render :thank_you
    else
      render :new
    end
  end
  
end
