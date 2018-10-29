class PollsController < ApplicationController

  before_action :authenticate_user!
  # before_filter :allow_iframe_requests


  # def allow_iframe_requests
  #   response.headers.delete('X-Frame-Options')
  # end


  def index
    response.headers.delete('X-Frame-Options')
    @polls = Poll.all
  end

  def new
    response.headers.delete('X-Frame-Options')
    @poll = Poll.new
  end

  def create
    response.headers.delete('X-Frame-Options')
    @poll = Poll.new(poll_params)
    if @poll.save
      (User.all.uniq - [current_user]).each do |user|
        Notification.create(recipient: user, actor: current_user, action: "polled", notifiable: @poll)
      end
      flash[:success] = 'Poll was created!'
      redirect_to polls_path
    else
      render 'new'
    end
  end

  def show
    @poll = Poll.includes(:vote_options).find_by_id(params[:id])
  end

  def edit
    @poll = Poll.find_by_id(params[:id])
  end

  def update
    @poll = Poll.find_by_id(params[:id])
    if @poll.update_attributes(poll_params)
      flash[:success] = 'Poll was updated!'
      redirect_to polls_path
    else
      render 'edit'
    end
  end

  def destroy
    @poll = Poll.find_by_id(params[:id])
    if @poll.destroy
      flash[:success] = 'Poll was destroyed!'
    else
      flash[:warning] = 'Error destroying poll...'
    end
    redirect_to polls_path
  end

  private

  def poll_params
    params.require(:poll).permit(:topic, vote_options_attributes: [:id, :title, :_destroy])
  end
end


