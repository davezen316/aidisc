class User < ApplicationRecord
  include Clearance::User

  has_many :disc_test_results
end
