class Saat < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :client
end
