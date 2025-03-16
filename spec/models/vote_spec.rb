require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, user: user, question: question) }

  describe "validations" do
    it "is valid with a user and votable" do
      vote = build(:vote, user: user, votable: question)
      expect(vote).to be_valid
    end

    it "is invalid without a user" do
      vote = build(:vote, user: nil, votable: question)
      expect(vote).not_to be_valid
      expect(vote.errors[:user]).to include("must exist")
    end

    it "is invalid without a votable" do
      vote = build(:vote, user: user, votable: nil)
      expect(vote).not_to be_valid
      expect(vote.errors[:votable]).to include("must exist")
    end

    it "is invalid with a duplicate vote by the same user on the same votable" do
      create(:vote, user: user, votable: question)
      duplicate_vote = build(:vote, user: user, votable: question)
      expect(duplicate_vote).not_to be_valid
      expect(duplicate_vote.errors[:user_id]).to include("has already been taken")
    end
  end

  describe "custom methods" do
    let(:vote) { create(:vote, user: user, votable: question) }

    it "updates the vote value to 1 when upvoted" do
      vote.upvote
      expect(vote.value).to eq 1
    end

    it "updates the vote value to -1 when downvoted" do
      vote.downvote
      expect(vote.value).to eq(-1)
    end

    it "destroys the vote when unvoted" do
      vote.unvote
      expect(Vote.find_by(id: vote.id)).to be_nil
    end
  end
end
