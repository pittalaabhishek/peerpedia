require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, user: user, question: question) }

  describe "validations" do
    it "is valid with a body, user, and answer" do
      comment = build(:comment, user: user, answer: answer)
      expect(comment).to be_valid
    end

    it "is invalid without a body" do
      comment = build(:comment, body: nil, user: user, answer: answer)
      expect(comment).not_to be_valid
      expect(comment.errors[:body]).to include("can't be blank")
    end

    it "is invalid without a user" do
      comment = build(:comment, user: nil, answer: answer)
      expect(comment).not_to be_valid
      expect(comment.errors[:user]).to include("must exist")
    end

    it "is invalid without an answer" do
      comment = build(:comment, user: user, answer: nil)
      expect(comment).not_to be_valid
      expect(comment.errors[:answer]).to include("must exist")
    end
  end

  describe "scopes" do
    it "orders comments by creation date in ascending order" do
      comment1 = create(:comment, user: user, answer: answer, created_at: 1.day.ago)
      comment2 = create(:comment, user: user, answer: answer, created_at: Time.current)
      expect(Comment.all).to eq [ comment1, comment2 ]
    end
  end
end
