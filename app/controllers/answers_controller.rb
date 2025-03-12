class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [ :create, :edit, :update, :destroy ]
  before_action :set_answer, only: [ :edit, :update, :destroy, :upvote, :downvote, :unvote ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to question_path(@question), notice: "Your answer has been posted!"
    else
      redirect_to question_path(@question), alert: "Failed to post your answer. Please try again."
    end
  end

  def edit
  end

  def upvote
    @answer.upvote(current_user)
    redirect_to question_path(@answer.question)
  end

  def unvote
    @answer.unvote(current_user)
    redirect_to question_path(@answer.question)
  end

  def downvote
    @answer.downvote(current_user)
    redirect_to question_path(@answer.question)
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@question)
    else
      render :edit, alert: "There was an issue updating answer. PLease try again."
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def authorize_user!
    unless @answer.user == current_user
      redirect_to question_path(@question), alert: "You are not authorized to perform this action."
    end
  end
end
