require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "POST /articles" do
    subject do
      post "/articles",
        headers: { "Content-Type" => "application/json" },
        params: params.to_json
    end

    context "正しいリクエストがあった場合" do
      let (:params) { { title: 'text', content: 'content' } }

      it "status code 200を返す" do
        subject
        expect(response.status).to eq(200)
      end

      it "正しいレスポンスが返ること" do
        subject
        response_body = JSON.load(response.body)
        created_article = Article.last

        expect(response_body['message']).to eq "SUCCESS"
        expect(response_body['data']['id']).to eq created_article.id
        expect(response_body['data']['title']).to eq params[:title]
        expect(response_body['data']['content']).to eq params[:content]
      end

      it "データが作成されること" do
        expect { subject }.to change{ Article.count }.by(1)

        created_article = Article.last

        expect(created_article.title).to eq params[:title]
        expect(created_article.content).to eq params[:content]
      end
    end

    context "誤ったリクエストがあった場合" do
      let (:params) { { title: '', content: 'content' } }

      it "status code 400を返す" do
        subject
        expect(response.status).to eq(400)
      end

      it "正しいレスポンスが返ること" do
        subject
        response_body = JSON.load(response.body)
        expect(response_body['message']).to eq "FAILURE"
        expect(response_body['detail']).to eq ({ "title" => ["can't be blank"] })
      end

      it "データが増減しないこと" do
        expect { subject }.to change{ Article.count }.by(0)
      end
    end
  end
end
