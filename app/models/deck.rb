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
  private
end
