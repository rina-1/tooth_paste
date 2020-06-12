class Admins::GenresController < ApplicationController
    def index
        @genre = Genre.new 
        @genres = Genre.all
    end
    def create
        @genre = Genre.new(genre_params)
        if @genre.save
            flash[:notice] = "ジャンル新規登録成功しました"
            redirect_back(fallback_location: admins_genres_path)
            # =redirect_to request.refererも該当ページに遷移する直前に閲覧されていた参照元に戻るために同じように使える
        else
            @genres = Genre.all
            flash[:notice] = "更新に失敗しました。入力を確認してください。"
            render :index
        end
    end

    private
	def genre_params
        params.require(:genre).permit(:genre_name)
    end
end