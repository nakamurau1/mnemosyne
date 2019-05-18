require 'csv'

csv_data = CSV.read(ARGV[0], headers: false)
puts "デッキの登録を開始します。"

user = User.where(email: "fyuichi@gmail.com").first
deck = user.decks.build
deck.title = csv_data[0][0]
deck.description = csv_data[0][1]
deck.public = true
deck.save!

csv_data.each_with_index do |data,i|
  next if i == 0
  item = deck.items.build
  item.front_text = data[0]
  item.back_text = data[1]
  item.user = deck.user
  item.save!
end

puts "デッキの登録が完了しました。"