require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { build(:article) }

  describe "#validations" do
    it '正常なデータが作成できること' do
      expect(article).to be_valid
    end

    context "title" do
      it 'titleが空の場合、不正データとなる' do
        
        article.title = ''
 
        expect(article).not_to be_valid
        expect(article.errors[:title]).to include("can't be blank")
      end
    end
  end
end
