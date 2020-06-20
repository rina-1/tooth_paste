class Paste < ApplicationRecord
    belongs_to :genre
    has_many :admin_recommeds
    has_many :user_favorites, dependent: :destroy
    attachment :image
    # validates :tooth_paste_name, uniqueness: true, presence: true
    # validates :price, presence: true

    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
          genre = Genre.find_by(genre_name: row["genre_name"]) || new
          row['genre_id'] = genre.id
          # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
          paste = find_by(id: row["id"]) || new
          # CSVからデータを取得し、設定する
          paste.attributes = row.to_hash.slice(*updatable_attributes)
          # 画像保存
          # paste_image = Paste.new
          # image = "/Users/kakiuchirina/Desktop/work/vagrant/tooth_paste/app/assets/images/paste_image/57a85ea1ed2f715039c26b1c49ecd2dd.jpg"
          # # "#{Rails.root.join('app', '/assets/images/paste_image/57a85ea1ed2f715039c26b1c49ecd2dd.jpg')}"
          # # "tooth_paste/app/assets/images/paste_image/57a85ea1ed2f715039c26b1c49ecd2dd.jpg"
          # paste_image = File.open(image)
          # row['image_id'] = paste_image

          paste.save
          # byebug
        end
      end
    
      # 更新を許可するカラムを定義
      def self.updatable_attributes
        ["id", "tooth_paste_name", "price", "genre_id"]
      end
end
