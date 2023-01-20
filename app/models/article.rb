class Article < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :content, presence: true
end
