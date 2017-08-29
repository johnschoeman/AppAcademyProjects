class GoalsController < ApplicationController
  before_action :require_login

  def new
    # @goal ||= Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    # byebug
    if @goal.save

      redirect_to goal_url(@goal.id)
    else
      flash[:errors] = @goal.errors.full_messages

      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    @comments =  @goal.goal_comments
  end

  def destroy
  end

  def update
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :details, :private, :finished)
  end
end
