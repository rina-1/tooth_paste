class Users::UserFavoritesController < ApplicationController
    def select
      @genres = Genre.all
      @user_favorite = UserFavorite.new
      @q = Paste.ransack(params[:q])
      @pastes = {}  #eash文に渡すように空の@pastes定義しておく（エラー対策）
      if params[:q].present?  #検索された場合の処理
        @paste = @q.result(distinct: true)
        @pastes = @paste.page(params[:page]).reverse_order.per(2)
      end
      @user_id = current_user.id
    end
    def new
      @paste = Paste.find(params[:id])
      @comment = UserFavorite.new
    end
    def create
      #comment = current_user.user_favorites.new(user_favorite_params)
      comment = UserFavorite.new(user_favorite_params)
      comment.user_id = current_user.id
      comment.save!
      redirect_to users_user_favorite_path(comment.id)
    end
    def show
      # @user_favorites = UserFavorite.where(user_id: current_user.id)
        #  ↑の書き方と↓同じ意味どっちでもokだが、↓の方が文法的にわかりやすいので◎
      # @user_favorites = current_user.user_favorites.all
       @user_favorites = current_user.user_favorites.all.page(params[:page]).reverse_order
      # @user_favorites = UserFavorite.all.page(params[:page]).reverse_order
      # @user_favorite = UserFavorite.all
      # @favorites = UserFavorite.find.page(params[:page]).reverse_order
      
    end
    def edit
      # @user_favorite = UserFavorite.where(user_id: current_user.id)
      #  ↑の書き方と↓同じ意味どっちでもokだが、↓の方が文法的にわかりやすいので◎
      @user_favorite = current_user.user_favorites.find(params[:id])
    end
    def update
      @user_favorite = current_user.user_favorites.find(params[:id])
      @user_favorite.save(user_favorite_params)
      redirect_to users_user_favorite_path(:id)
    end
    def destroy
    end
    def index
      # ↓pasteのランキング
      user_favorites = UserFavorite.joins(:paste).group("tooth_paste_name").order('count_all DESC').count
      @user_favorites = []    #空の配列を定義しておく
      user_favorites.each do |user_favorite|               #image表示させたいので、pasteの情報も欲しいので配列にいれる
        array = [
          user_favorite,
          Paste.find_by(tooth_paste_name: user_favorite[0])
        ]
        @user_favorites.push(array)                   #array=[0,1]で取れる
      end
      # ↓genre別のランキング
      # genre_id=1のランキング
      user_favorite_genre = UserFavorite.joins(:paste).where('pastes.genre_id = ?', 1).group("tooth_paste_name").order('count_all DESC').count
      @user_favorite_genre = []   #空の配列を定義しておく
      user_favorite_genre.each do |user_favorite_genre|               #pasteの情報も欲しいので配列にいれる
        array = [
          user_favorite_genre,
          Paste.find_by(tooth_paste_name: user_favorite_genre[0])
        ]
        @user_favorite_genre.push(array)                   #array=[0,1]で取れる
      end
      @admin_recommends = AdminRecommend.all
    end
    private
    def user_favorite_params
        params.require(:user_favorite).permit(:comment, :paste_id, :user_id)
    end
end
