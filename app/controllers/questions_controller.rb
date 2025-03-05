class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def index
    @questions = Question.all.includes(:user).order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to root_path, notice: "Your question has been posted!"
    else
      render :new, alert: "Failed to post the question. Please try again."
    end
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end
end
