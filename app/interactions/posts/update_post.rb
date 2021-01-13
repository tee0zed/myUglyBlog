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
      blog.title = title if title
      blog.subdomain = subdomain if subdomain

      if blog.save
        blog
      else
        error.merge!(blog.errors)
      end
    end
  end
end

