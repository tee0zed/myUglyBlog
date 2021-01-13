module Blogs
  class DestroyBlog < ActiveInteraction::Base
    object :blog

    def execute
      errors.merge!(blog.errors) unless blog.destroy
    end
  end
end

