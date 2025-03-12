class VotesController < ApplicationController
  before_action :authenticate_user!
  def destroy
    @answer = Answer.find(params[:id])
    @vote = @answer.votes.find_by(user: current_user)
    @vote.destroy if @vote
    redirect_to question_path(@answer.question)
  end
end
