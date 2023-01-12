class Blog < ApplicationRecord
  belongs_to :user
  # scope :test, -> (len) {where("LENGTH(title) > ?", len)}
  # scope :author_of, -> (var) { where(user_id: ?, var) }
end
