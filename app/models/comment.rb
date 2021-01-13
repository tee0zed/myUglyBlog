class Comment < ApplicationRecord
  belongs_to :post, required:  true
  belongs_to :user, optional: true

  has_rich_text :content
end
