# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
=begin
=end

Admin.create!(
    name: 'rina',
    email: 'rina@icloud.com',
    password: '123456'
)


Genre.create!(
    genre_name: 'ホワイトニング'
)
Genre.create!(
    genre_name: '歯周病予防'
)
Genre.create!(
    genre_name: '虫歯予防'
)

Genre.create!(
    genre_name: '知覚過敏'
)

require "csv"
CSV.foreach('db/paste6_21.csv', headers: true) do |row|
    genre = Genre.find_by(genre_name: row["genre_name"])
  Paste.create(
    genre_id: genre.id,
    tooth_paste_name: row['tooth_paste_name'],
    price: row['price'],
    # image_id: row['image_id']
  )
end

