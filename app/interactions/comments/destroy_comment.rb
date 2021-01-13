module Comments
  class DestroyComment < ActiveInteraction::Base
    object :comment

    def execute
      errors.merge!(comment.errors) unless comment.destroy
    end
  end
end

