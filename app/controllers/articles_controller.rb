class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
    # @article = Article.find(params[:id])
  end

  def update
    # @article = Article.find(params[:id])
    if @article.update(articles_params)
      flash[:notice] = "Article updated successfully"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(articles_params)

    if @article.save
      flash[:notice] = "Article created successfully"
      redirect_to article_path(@article)
    else
      render "new"
    end
    #   @article.save
    #   redirect_to article_path(@article)
  end

  def show
    # @article = Article.find(params[:id])
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article deleted succesfully"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def articles_params
    params.require(:article).permit(:title, :description)
  end
end
