class Users::PastesController < ApplicationController
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

    end
    def show
        @paste = Paste.find(params[:id])
        # user_comments = UserFavorite.find_by(paste_id: @paste.id)
        # @user_comments = UserFavorite.joins(:paste).where('paste_id = ?', @paste).group("paste_id")
        @user_comments = UserFavorite.where('paste_id = ?', @paste)
       
        # Paste.find_by(tooth_paste_name: user_favorite[0])
    end
end
