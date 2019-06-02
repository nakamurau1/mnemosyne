class Deck < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  default_scope { order(id: :desc) }

  def public_str
    if public?
      "公開"
    else
      "非公開"
    end
  end

  def copy_to(user)
    new_deck = self.deep_dup
    new_deck.user = user
    new_deck.public = false
    return false unless new_deck.save
    self.items.each do |item|
      new_item = item.deep_dup
      new_item.deck = new_deck
      new_item.user = user
      new_item.set_default_value
      return false unless new_item.save
    end
    return true
  end

  def updated_at_str
    self.updated_at.strftime("%Y/%m/%d")
  end

  def stop_learning
    self.items.each do |item|
      item.next_review_datetime = nil
      item.save(validate: false)
    end
    self.stop = true
    self.save(validate: false)
  end

  def resume_learning
    self.items.each do |item|
      item.next_review_datetime = Time.zone.now
      item.save(validate: false)
    end
    self.stop = false
    self.save(validate: false)
  end

  private
end
