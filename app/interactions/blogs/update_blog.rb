module Blogs
  class UpdateBlog < ActiveInteraction::Base
    object :blog

    with_options default: nil do
      string :title, :subdomain
    end

    validates :title,
              length: { maximum: 150 },
              if: :title_present?

    validates :subdomain,
              exclusion: { in: %w(www), message: '%{value} is reserved.' },
              if: :subdomain_present?

    def execute
      blog.title = title if title_present?
      blog.subdomain = subdomain if subdomain_present?

      if blog.save
        blog
      else
        error.merge!(blog.errors)
      end
    end

    private

    def title_present?
      title
    end

    def subdomain_present?
      subdomain
    end
  end
end

