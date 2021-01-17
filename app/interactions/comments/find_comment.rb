module Comments
  class FindComment < ActiveInteraction::Base
    integer :id

    def execute
      comment = Comment.find(id: id)

      if comment
        comment
      else
        errors.add(:id, t('comment.none'))
      end
    end
  end
end
