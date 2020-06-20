class Users::UserFavoritesController < ApplicationController
    def select
      @genres = Genre.all
      @user_favorite = UserFavorite.new
      @q = Paste.ransack(params[:q])
      @paste = @q.result(distinct: true)
    end
    def new
      @paste = Paste.find(params[:id])
      @comment = UserFavorite.new
    end
    def create
      #comment = current_user.user_favorites.new(user_favorite_params)
      comment = UserFavorite.new(user_favorite_params)
      comment.user_id = current_user.id
      comment.save
      redirect_to users_user_favorite_path(:id)
    end
    def show
     
       @user_favorites = UserFavorite.where(user_id: current_user.id)
        #  ↑の書き方と↓同じ意味どっちでもok??
        #  @user_favorites = current_user.user_favorites.all
    end
    def edit
      # @user_favorite = UserFavorite.where(user_id: current_user.id)
      #  ↑の書き方と↓同じ意味どっちでもok
      @user_favorite = current_user.user_favorites.find(params[:id])
    end
    def update
      @user_favorite = current_user.user_favorites.find(params[:id])
      @user_favorite.save(user_favorite_params)
      redirect_to users_user_favorite_path(:id)
    end
    def destroy
    end
    private
    def user_favorite_params
        params.require(:user_favorite).permit(:comment, :paste_id, :user_id)
    end
end
