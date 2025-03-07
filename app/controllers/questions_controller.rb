class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :set_question, only: [ :show, :edit, :update, :destroy ]

  def index
    @questions = Question.all.includes(:user).order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to root_path, notice: "Question updated successfully"
    else
      render :edit, alert: "Failed to update the question. PLease try again"
    end
  end

  def destroy
    @question.destroy
    redirect_to root_path, notice: "Question deleted successfully."
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.includes(:comments)
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

  def set_question
    @question = Question.find(params[:id])
  end
end
