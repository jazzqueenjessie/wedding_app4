class RsvpsController < ApplicationController

  def new
    @rsvp = Rsvp.new
  end
  
  def create
    @rsvp = Rsvp.new(params[:rsvp])
    if @rsvp.deliver
      flash[:success] = "Thank you for your RSVP! Please enjoy the rest of the website."
      redirect_to('/wedding.html')
      #render :thank_you
    else
      render :new
    end
  end
  
end
