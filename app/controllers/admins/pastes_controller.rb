class Admins::PastesController < ApplicationController
    def new
        @paste = Paste.new
        @pastes = Paste.all
    end
    def create
        @paste = Paste.new(paste_params)
        if @paste.save
            flash[:notice] = "歯磨き粉新規登録成功しました"
            redirect_back(fallback_location: admins_pastes_path)
        else
            @tooth_pastes = Paste.all
            flash[:notice] = "更新に失敗しました。入力を確認してください。"
            render :new
        end
    end
    private
	def paste_params
        params.require(:paste).permit(:tooth_paste_name, :image, :price, :genre_id)
    end
end
