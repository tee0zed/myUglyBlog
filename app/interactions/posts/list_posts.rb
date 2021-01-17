module Posts
  class ListPosts < ActiveInteraction::Base
    object :blog

    def execute
      blog.posts
    end
  end
end
