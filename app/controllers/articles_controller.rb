class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :show, :destroy ]
  before_action :required_user, except: [:index, :show]
  before_action :required_same_user, only: [:edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 4)
  end


  def create
    @article = Article.new(article_params)
    @article.user = current_user
    #debugger
    if @article.save
      flash[:success] = "You article saved successfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit
  end

  def update

    if @article.update(article_params)
      flash[:success] = "Your article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end

  end

  def show
    # @article = Article.find(params[:id])
  end

  def destroy
    
    @article.destroy
    flash[:danger] = "Your article was successfully deleted"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids:[])
  end

  def required_same_user
    if current_user != @article.user and current_user.admin?
      flash[:danger] = "You can only edit or delete articles you created"
      redirect_to root_path
    end
  end

end