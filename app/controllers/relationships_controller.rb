class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    add_follower(@user)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    add_follower(@user)
  end

  private

  def add_follower(user)
    current_user.follow!(user)
    respond_to do |format|
      format.html { redirect_to user }
      format.js
    end
  end
end