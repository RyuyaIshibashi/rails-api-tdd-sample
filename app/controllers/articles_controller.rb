class ArticlesController < ApplicationController
  def create
    article = Article.new(article_params)
    if article.save
      render status: 200, json: {
        message: 'SUCCESS',
        data: article
      }
    else
      render status: 400, json: {
        message: 'FAILURE',
        detail: article.errors.messages
      }
    end
  end

  private
  def article_params
    params.permit(:title, :content)
  end
end
