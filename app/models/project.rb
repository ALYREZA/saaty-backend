class Project < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 100 },uniqueness: { scope: :client,
    message: "is the same in that client" }
  validates :color, presence: true,length: { is: 6 }, allow_blank: true
  belongs_to :user
  belongs_to :client
  has_many :times, class_name: "Saat", foreign_key: "project_id"
end
