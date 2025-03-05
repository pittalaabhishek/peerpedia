class AnswersController < ApplicationController
  before_action :authenticate_user!

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

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
