# frozen_string_literal: true

# Right now, users are just administrators but possibly this
# will change in the future
class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_secure_password
end
