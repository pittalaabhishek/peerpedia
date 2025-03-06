class CommentsController < ApplicationController
  # before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_question_and_answer, only: [ :create, :edit, :update, :destroy ]
  before_action :set_comment, only: [ :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def create
    @comment = @answer.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      puts "Inside saving comment"
      # byebug
      redirect_to question_path(@question), notice: "Comment was successfully created."
    else
      redirect_to question_path(@question), alert: "Failed to create comment."
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to question_path(@question), notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to question_path(@question), notice: "Comment was successfully deleted."
  end

  private

  def set_question_and_answer
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:answer_id])
    # byebug
  end

  def set_comment
    @comment = @answer.comments.find(params[:id])
  end

  def authorize_user!
    unless @comment.user == current_user
      redirect_to question_path(@question), alert: "You are not authorized to perform this action."
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
