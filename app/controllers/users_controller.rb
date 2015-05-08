class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @usert = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    user_params=params.require(:usert).permit(:name, :email, :password,
                                         :password_confirmation)
    @user = User.new(user_params)
    if @usert.save
      sign_in @usert
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @usert
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    user_params=params.require(:usert).permit(:name, :email, :password,
                                              :password_confirmation)
    if @usert.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @usert
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @usert = User.find(params[:id])
    @userts = @usert.followed_userts.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @usert = User.find(params[:id])
    @userts = @usert.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    # Before filters

    def correct_user
      @usert = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@usert)
    end

    def admin_user
      redirect_to(root_url) unless current_usert.admin?
    end
  end
