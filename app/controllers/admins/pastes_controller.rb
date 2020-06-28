class Admins::PastesController < ApplicationController
    def new
        @paste = Paste.new
        @pastes = Paste.page(params[:page]).reverse_order
    end
    def create
        @paste = Paste.new(paste_params)
        @pastes = Paste.all
        if @paste.save
            flash[:notice] = "歯磨き粉新規登録成功しました"
            redirect_back(fallback_location: new_admins_paste_path)
        else
            @tooth_pastes = Paste.all
            @pastes = Paste.page(params[:page]).reverse_order
            flash[:notice] = "登録に失敗しました。入力を確認してください。<br>・製品名記入欄が空ではないですか？<br>・値段記入欄が空ではないですか?<br>・既に登録してある製品ではないですか？".html_safe
            render :new
        end
    end
    def edit
        @paste = Paste.find(params[:id])        
    end
    def update
        @paste = Paste.find(params[:id])
		if @paste.update(paste_params)
			flash[:notice] = "歯磨き粉の登録内容を編集しました"
			redirect_to action: :new
        else
            @paste = Paste.new
            @pastes = Paste.all
			flash[:notice] = "歯磨き粉の登録内容の編集に失敗しました。入力を確認してください。<br>・製品名記入欄が空ではないですか?<br>・値段記入欄が空ではないですか？<br>・既に登録してある製品名ではないですか？".html_safe
			render :new
		end
    end
    def destroy
        @paste = Paste.find(params[:id])
        @paste.destroy
        flash[:notice] = "歯磨き粉の登録を削除しました"
        redirect_back(fallback_location: new_admins_paste_path)
    end

    def import
        # fileはtmpに自動で一時保存される
        require "csv"                   #file→csvファイルのこと、File→Railsのファイルのこと
        csv_file = params[:file].path   #:fileはcsvfile自体のこと。パラメーターで渡ってきたデータ
        CSV.foreach(csv_file, headers: true) do |row|
            genre = Genre.find_by(genre_name: row["genre_name"])
            if row["file"].nil? || row["file"] == ""   #csvの中の"file"（headerにかかれてるアトリビュートのこと）
                # file.close必要な書き方(fileは開いたら閉じる必要がある)
                file = File.open("#{Rails.root}/public/icon_2018_25.png", "rb")    #画像ファイル開いてる
                Paste.create(
                    genre_id: genre.id,
                    tooth_paste_name: row['tooth_paste_name'],
                    price: row['price'],
                    image: file
                    )
                file.close
            else
                 # do endの場合はfile.close必要じゃない
                File.open(Rails.root.join(row['file']), "rb") do |file| #Rails.root.join(row['file])は画像があるところまでのpath、"rb"はreedbinaryのこと
                    Paste.create(
                    genre_id: genre.id,
                    tooth_paste_name: row['tooth_paste_name'],
                    price: row['price'],
                    image: file
                    )
                end
            end     
        end  
        redirect_to new_admins_paste_path
    end

    private
	def paste_params
        params.require(:paste).permit(:tooth_paste_name, :image, :price, :genre_id)
    end
end
