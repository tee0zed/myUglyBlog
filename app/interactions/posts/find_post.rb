module Posts
  class FindPost < ActiveInteraction::Base
    integer :id

    def execute
      post = Post.find(id: id)

      if post
        post
      else
        errors.add(:id, t('post.none'))
      end
    end
  end
end
