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

  private
end
