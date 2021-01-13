module Posts
  class ListBlogs < ActiveInteraction::Base
    object :blog

    def execute
      blog.posts
    end
  end
end
