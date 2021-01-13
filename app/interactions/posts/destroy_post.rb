module Posts
  class DestroyPost < ActiveInteraction::Base
    object :post

    def execute
      errors.merge!(post.errors) unless post.destroy
    end
  end
end

