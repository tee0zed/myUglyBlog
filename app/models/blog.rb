class Blog < ApplicationRecord
  belongs_to :user

  has_many :posts, dependent: :destroy

  validates :subdomain, uniqueness: true

  before_validation :sanitize_subdomain

  private

  def sanitize_subdomain
    self.subdomain = self.subdomain.parameterize
  end
end
