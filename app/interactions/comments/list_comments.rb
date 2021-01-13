module Comments
  class ListComments < ActiveInteraction::Base
    object :post

    def execute
      post.comments
    end
  end
end
