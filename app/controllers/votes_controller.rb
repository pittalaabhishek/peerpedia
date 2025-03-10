class VotesController < ApplicationController
  before_action :authenticate_user!

  def upvote
    @answer = Answer.find(params[:id])
    @vote = @answer.votes.find_or_initialize_by(user: current_user)
    @vote.value += 1
    @vote.save
    redirect_to question_path(@answer.question)
  end

  def downvote
    @answer = Answer.find(params[:id])
    @vote = @answer.votes.find_or_initialize_by(user: current_user)
    @vote.value -= 1
    @vote.save
    redirect_to question_path(@answer.question)
  end

  def destroy
    @answer = Answer.find(params[:id])
    @vote = @answer.votes.find_by(user: current_user)
    @vote.destroy if @vote
    redirect_to question_path(@answer.question)
  end
end
