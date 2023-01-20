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

      it 'titleが一意でない場合、不正データとなる' do
        article_1 = create(:article)
        expect(article_1).to be_valid

        article_2 = build(:article, title: article_1.title)

        expect(article_2).not_to be_valid
        expect(article_2.errors[:title]).to include("has already been taken")

        article_2.title = 'new title'
        expect(article_2).to be_valid
      end

      it 'titleは50文字以内でない場合、不正データとなる' do
        article.title = 'a' * 50
        expect(article).to be_valid

        article.title = 'a' * 51
        expect(article).not_to be_valid
        expect(article.errors[:title]).to include("is too long (maximum is 50 characters)")
      end
    end
  end
end
