require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { build(:article) }

  describe "#validations" do
    it '正常なデータが作成できること' do
      expect(article).to be_valid
    end
  end
end
