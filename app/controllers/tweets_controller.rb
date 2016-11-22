#require 'twitter' #confg/initializers/twitter.rb
class TweetsController < ApplicationController
  before_filter :check_twitter
  def show
  end

  def new
  end

  def create
    @picture = params[:picture]
    if @picture.nil?
      @picture = Rails.root + 'app/assets/images/missing/shave_record/medium/missing.png'
    end
    $client.update_with_media(params[:message], File.new(@picture))
    redirect_to shaving_records_url, notice: 'Tweet sent.'
  end

  def twitter_params
    params.require(:tweet).permit(:message, :picture)
  end
end
