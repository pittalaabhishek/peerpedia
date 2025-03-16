require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { create(:user) }

  describe "validations" do
    it "is valid with a body and user" do
      question = build(:question, user: user)
      expect(question).to be_valid
    end

    it "is invalid without a body" do
      question = build(:question, body: nil, user: user)
      expect(question).not_to be_valid
      expect(question.errors[:body]).to include("can't be blank")
    end

    it "is invalid without a user" do
      question = build(:question, user: nil)
      expect(question).not_to be_valid
      expect(question.errors[:user]).to include("must exist")
    end
  end

  describe "scopes" do
    it "orders questions by creation date in descending order" do
      question1 = create(:question, user: user, created_at: 1.day.ago)
      question2 = create(:question, user: user, created_at: Time.current)
      expect(Question.all).to eq [ question2, question1 ]
    end
  end

  describe "voting methods" do
    let(:question) { create(:question, user: user) }

    it "upvotes a question" do
      question.upvote(user)
      vote = question.votes.find_by(user: user)
      expect(vote.value).to eq 1
    end

    it "downvotes a question" do
      question.downvote(user)
      vote = question.votes.find_by(user: user)
      expect(vote.value).to eq(-1)
    end

    it "unvotes a question" do
      question.upvote(user)
      question.unvote(user)
      expect(question.votes.find_by(user: user)).to be_nil
    end
  end
end
