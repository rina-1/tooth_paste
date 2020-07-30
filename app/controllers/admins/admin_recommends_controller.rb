class Admins::AdminRecommendsController < ApplicationController
    def new
        @genres = Genre.all
        @recommend = AdminRecommend.new
        @q = Paste.ransack(params[:q])
        @pastes = {}
        if params[:q].present?
          @paste = @q.result(distinct: true)
          @pastes = @paste.page(params[:page]).reverse_order.per(5)
        end
        # ↓ターミナルのログで、入ってるデータを確認することができる
        # logger.debug 'zzzzzzzz'　　　　　　　　　　　　 ←ログで見つけやすいように適当な文字打ってあるだけなのでなくてもok
        # logger.debug current_admin.inspect　　　　　　←確認したいインスタンス.inspectで中身のデータ見れる
        # logger.debug 'zzzzzzzzz'
        
    end
    def create
        @recommend = AdminRecommend.new(recommend_params)
        @recommend.admin_id = current_admin.id
        if @recommend.save
            flash[:notice] = "お気に入りを登録しました"
            redirect_to admins_admin_recommends_path
        else
            @genres = Genre.all
            @q = Paste.ransack(params[:q])
            @pastes = {}
            if params[:q].present?
              @paste = @q.result(distinct: true)
              @pastes = @paste.page(params[:page]).reverse_order.per(5)
            end
            flash.now[:notice] = "登録に失敗しました、内容を確認して下さい<br>・コメント内容が空ではないですか？<br>・既にお気に入り登録した製品ではないですか?".html_safe
            render :new
        end
             
    end
    def edit
        @recommend = AdminRecommend.find(params[:id])        
    end
    def update
        @recommend = AdminRecommend.find(params[:id])
		if @recommend.update(recommend_params)
			flash[:notice] = "コメントを編集しました"
			redirect_to action: :index
		else
			flash.now[:notice] = "コメント編集に失敗しました。入力を確認してください。<br>・コメント記入欄が空ではないですか?".html_safe
			render :edit
		end
    end
    def destroy
        @recommend = AdminRecommend.find(params[:id])
        if  @recommend.destroy
            flash[:notice] = "お気に入りを削除しました"
            redirect_back(fallback_location: admins_genres_path)
        else
            flash[:notice] = "削除出来ませんでした"
            redirect_back(fallback_location: root_path)
        end
    end
    def index
        @recommends = AdminRecommend.page(params[:page]).reverse_order
    end
    private
	def recommend_params
        params.require(:admin_recommend).permit(:paste_id, :comment, :admin_id)
    end
end