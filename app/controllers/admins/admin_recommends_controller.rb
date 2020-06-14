class Admins::AdminRecommendsController < ApplicationController
    def new
        @genres = Genre.all
        @recommend = AdminRecommend.new
        @q = Paste.ransack(params[:q])
        @paste = @q.result(distinct: true)
    end
    def create
    end
    def edit
        @recommend = AdminRecommend.find(params[:id])
    end
    def update
        @recommend = AdminRecommend.find(params[:id])
		if @recommend.update(recommend_params)
			flash[:notice] = "ジャンルを編集しました！"
			redirect_to action: :index
		else
			flash[:notice] = "編集に失敗しました。入力を確認してください。"
			render :edit
		end
    end
    def destroy
        @recommend = AdminRecommend.find(params[:id])
        @recommend.destroy
        redirect_back(fallback_location: admins_genres_path)
    end
    def index
        @recommends = AdminRecommend.all
    end
    private
	def recommend_params
        params.require(:admin_recommend).permit(:paste_id, :comment)
    end
end