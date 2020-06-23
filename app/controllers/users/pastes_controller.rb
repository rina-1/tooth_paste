class Users::PastesController < ApplicationController
    def index
    end
    def show
        @paste = Paste.find(params[:id])
        # user_comments = UserFavorite.find_by(paste_id: @paste.id)
        # @user_comments = UserFavorite.joins(:paste).where('paste_id = ?', @paste).group("paste_id")
        @user_comments = UserFavorite.where('paste_id = ?', @paste)
       

        # Paste.find_by(tooth_paste_name: user_favorite[0])
    end
end
