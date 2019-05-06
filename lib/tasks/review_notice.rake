namespace :review_notice do
  task :nine => :environment do
    users = User.where(notice: "9")
    users.each do |user|
      review_items_count = user.review_items.count
      if review_items_count > 0 && !user.guest?
        UserMailer.review_notice(user, review_items_count).deliver_now
      end
    end
  end

  task :nineteen => :environment do
    users = User.where(notice: "19")
    users.each do |user|
      review_items_count = user.review_items.count
      if review_items_count > 0 && !user.guest?
        UserMailer.review_notice(user, review_items_count).deliver_now
      end
    end
  end
end