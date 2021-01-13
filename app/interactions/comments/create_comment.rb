module Comments
  class CreateComment < ActiveInteraction::Base
    string :content
    object :user, default: nil

    validates :content,
              presence: true,
              length: { maximum: 350 }

    def to_model
      Comment.new
    end

    def execute
      comment = Comment.new(context: context)
      comment.user = user if user

      if comment.save
        comment
      else
        error.merge!(comment.errors)
      end
    end
  end
end

