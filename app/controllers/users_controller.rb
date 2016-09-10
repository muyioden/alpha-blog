class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

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
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Alpha Blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
   
  end

  def update

    if @user.update(user_params)
      flash[:success] = "You have successfully updated your record"
      redirect_to articles_path

    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all the articles created by user has been deleted"
    redirect_to users_path
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end

  private
  def user_params
    params.required(:user).permit(:username, :email, :password)
  end

  def set_user
     @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit or update your own profile"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin user can perform this action"
      redirect_to root_path
    end
  end

end