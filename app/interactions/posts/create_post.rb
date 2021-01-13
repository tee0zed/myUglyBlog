module Posts
  class CreatePost < ActiveInteraction::Base
    string :title, :content
    object :user

    validates :title,
              presence: true,
              length: { maximum: 250 }

    validates :content,
              presence: true

    validates :user,
              presence: true

    def to_model
      Post.new
    end

    def execute
      post = Post.new(
        title: title,
        content: content,
        user: user
      )

      if post.save
        post
      else
        error.merge!(post.errors)
      end
    end
  end
end

