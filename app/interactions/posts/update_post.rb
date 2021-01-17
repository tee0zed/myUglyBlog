module Posts
  class UpdatePost < ActiveInteraction::Base
    object :post

    with_options default: nil do
      string :title, :content
    end

    validates :title,
              length: { maximum: 150 },
              if: 'title'

    validates :subdomain,
              exclusion: { in: %w(www), message: '%{value} is reserved.' },
              if: 'subdomain'

    def execute
      post.title = title if title
      post.content = content if content

      if post.save
        post
      else
        error.merge!(post.errors)
      end
    end
  end
end

