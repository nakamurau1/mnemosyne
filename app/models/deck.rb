class Deck < ApplicationRecord
  after_initialize :_set_default_value, if: :new_record?
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

    def _set_default_value
      self.public = false
    end
end
