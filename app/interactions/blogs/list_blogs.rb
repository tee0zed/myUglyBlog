module Blogs
  class ListBlogs < ActiveInteraction::Base
    def execute
      Blog.all
    end
  end
end
