class Users::UserFavoritesController < ApplicationController
    def select
      @genres = Genre.all
      @user_favorite = UserFavorite.new
      @q = Paste.ransack(params[:q])
      @pastes = {}  #eash文に渡すように空の@pastes定義しておく（エラー対策）
      if params[:q].present?  #検索された場合の処理
        @paste = @q.result(distinct: true)
        @pastes = @paste.page(params[:page]).reverse_order.per(5)
      end
      @user_id = current_user.id
    end
    def new
      @paste = Paste.find(params[:id])
      @comment = UserFavorite.new
    end
    def create
      comment = UserFavorite.new(user_favorite_params)
      comment.user_id = current_user.id
      comment.save!
      redirect_to users_user_favorite_path(comment.id)
    end
    def show
       @user_favorites = current_user.user_favorites.all.page(params[:page]).reverse_order

    end
    def edit
      # @user_favorite = UserFavorite.where(user_id: current_user.id)
      #  ↑の書き方と↓同じ意味どっちでもokだが、↓の方が文法的にわかりやすいので◎
      @user_favorite = current_user.user_favorites.find(params[:id])
    end
    def update
      @user_favorite = current_user.user_favorites.find(params[:id])
      @user_favorite.update(user_favorite_params)
      redirect_to users_user_favorite_path(:id)
    end
    def destroy
      @user_favorite = current_user.user_favorites.find(params[:id])
      @user_favorite.destroy
      # flash[:notice] = "お気に入りを削除しました"
      redirect_to users_user_favorite_path(:id)
    end
    def index
      # pasteの総合ランキング
      user_favorites = UserFavorite.joins(:paste).group("tooth_paste_name").order('count_all DESC').count
      @user_favorites = []    #空の配列を定義しておく
      user_favorites.each do |user_favorite|               #image表示させたいので、pasteの情報も欲しいので配列にいれる
        array = [
          user_favorite,
          Paste.find_by(tooth_paste_name: user_favorite[0])
        ]
        @user_favorites.push(array)                   #array=[0,1]で取れる
      end     
       
      @admin_recommends = []
      @admin_recommends = AdminRecommend.page(params[:page]).reverse_order.per(3)

       # genre別ランキング
      @genres = Genre.all
      @q = Genre.ransack(params[:q])
      @user_favorite_genre = {}  #eash文に渡すように空の@pastes定義しておく（エラー対策）
      if params[:q].present?  #検索された場合の処理
        @genre = @q.result(distinct: true)
        user_favorite_genre = UserFavorite.joins(:paste).where('pastes.genre_id = ?', @genre.ids).group("tooth_paste_name").order('count_all DESC').count
        @user_favorite_genre = []   #空の配列を定義しておく
        user_favorite_genre.each do |user_favorite_genre|               #pasteの情報も欲しいので配列にいれる
          array = [
            user_favorite_genre,
            Paste.find_by(tooth_paste_name: user_favorite_genre[0])
          ]
          @user_favorite_genre.push(array)                   #array=[0,1]で取れる
        end
      end
      @user_id = current_user.id
    end
    private
    def user_favorite_params
        params.require(:user_favorite).permit(:comment, :paste_id, :user_id)
    end
end
