module Blogs
  class CreateBlog < ActiveInteraction::Base
    string :title, :subdomain
    object :user

    validates :title,
              presence: true,
              length: { maximum: 150 }

    validates :subdomain,
              presence: true,
              exclusion: { in: %w(www), message: '%{value} is reserved.' }

    validates :user,
              presence: true

    def to_model
      Blog.new
    end

    def execute
      blog = Blog.new(
        title: title,
        subdomain: subdomain,
        user: user
      )

      if blog.save
        blog
      else
        error.merge!(blog.errors)
      end
    end
  end
end

