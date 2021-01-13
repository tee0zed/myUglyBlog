class AddSubdomainToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :subdomain, :string, { null: true }
  end
end
