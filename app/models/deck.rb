class Deck < ApplicationRecord
  after_initialize :_set_default_value, if: :new_record?
  belongs_to :user
  has_many :items, dependent: :destroy

  private

    def _set_default_value
      self.public = false
    end
end
