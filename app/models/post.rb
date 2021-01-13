class Post < ApplicationRecord
  belongs_to :blog, required: true
  belongs_to :user, required: true

  has_many :comments, dependent: :destroy

  has_rich_text :content
end
