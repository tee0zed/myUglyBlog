module Comments
  class CreateComment < ActiveInteraction::Base
    string :content
    object :post
    object :user, default: nil

    validates :content,
              presence: true,
              length: { maximum: 350 }

    validates :post,
              presence: true

    def to_model
      Comment.new
    end

    def execute
      comment = Comment.new(
        context: context,
        post: post,
        user: user
      )

      if comment.save
        comment
      else
        error.merge!(comment.errors)
      end
    end
  end
end

