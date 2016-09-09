class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  def create
    # debugger
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to Alpha Blog #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "You have successfully updated your record"
      redirect_to articles_path

    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end

  private
  def user_params
    params.required(:user).permit(:username, :email, :password)
  end

end