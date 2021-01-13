module Blogs
  class FindBlog < ActiveInteraction::Base
    string :subdomain

    def execute
      Blog.find_by(subdomain: subdomain)
    end
  end
end
