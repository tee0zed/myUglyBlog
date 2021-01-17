module Posts
  class CreatePost < ActiveInteraction::Base
    string :title, :content
    object :user, :blog

    validates :title, length: { maximum: 250 }

    validates :content, :user, :blog, :title,
              presence: true

    def to_model
      Post.new
    end

    def execute
      post = Post.new(
        title: title,
        content: content,
        user: user,
        blog: blog
      )

      if post.save
        post
      else
        error.merge!(post.errors)
      end
    end
  end
end

