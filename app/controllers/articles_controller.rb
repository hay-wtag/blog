class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
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
      flash[:success] = "Article updated successfully"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(articles_params)
    @article.user = current_user

    if @article.save
      flash[:success] = "Article created successfully"
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
    flash[:danger] = "Article deleted succesfully"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def articles_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user.admin?
      true
    elsif current_user != @article.user
      flash[:danger] = "Can not edit or delete others article "
      redirect_to root_path
    end
  end
end
