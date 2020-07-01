class Admins::GenresController < ApplicationController
    def index
        @genre = Genre.new 
        @genres = Genre.page(params[:page]).reverse_order
    end
    def create
        @genre = Genre.new(genre_params)
        if @genre.save
            flash[:notice] = "ジャンル新規登録成功しました"
            redirect_back(fallback_location: admins_genres_path)
            # =redirect_to request.refererも該当ページに遷移する直前に閲覧されていた参照元に戻るために同じように使える
        else
            @genres = Genre.all
            flash.now[:notice] = "更新に失敗しました。入力を確認してください。<br>・ジャンル記入欄が空ではないですか?<br>・既にあるジャンル名ではないですか？".html_safe
            render :index
        end
    end
    def destroy
        @genre = Genre.find(params[:id])
        @genre.destroy
        flash[:notice] = "Genreを削除しました"
        redirect_back(fallback_location: admins_genres_path)
    end

    private
	def genre_params
        params.require(:genre).permit(:genre_name)
    end
end
