require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe "validations" do
    it "is valid with a body, user, and question" do
      answer = build(:answer, user: user, question: question)
      expect(answer).to be_valid
    end

    it "is invalid without a body" do
      answer = build(:answer, body: nil, user: user, question: question)
      expect(answer).not_to be_valid
      expect(answer.errors[:body]).to include("can't be blank")
    end

    it "is invalid without a user" do
      answer = build(:answer, user: nil, question: question)
      expect(answer).not_to be_valid
      expect(answer.errors[:user]).to include("must exist")
    end

    it "is invalid without a question" do
      answer = build(:answer, user: user, question: nil)
      expect(answer).not_to be_valid
      expect(answer.errors[:question]).to include("must exist")
    end
  end

  describe "scopes" do
    it "orders answers by creation date in descending order" do
      answer1 = create(:answer, user: user, question: question, created_at: 1.day.ago)
      answer2 = create(:answer, user: user, question: question, created_at: Time.current)
      expect(Answer.all).to eq [ answer2, answer1 ]
    end
  end

  describe "voting methods" do
    let(:answer) { create(:answer, user: user, question: question) }

    it "upvotes an answer" do
      answer.upvote(user)
      vote = answer.votes.find_by(user: user)
      expect(vote.value).to eq 1
    end

    it "downvotes an answer" do
      answer.downvote(user)
      vote = answer.votes.find_by(user: user)
      expect(vote.value).to eq(-1)
    end

    it "unvotes an answer" do
      answer.upvote(user)
      answer.unvote(user)
      expect(answer.votes.find_by(user: user)).to be_nil
    end
  end
end
