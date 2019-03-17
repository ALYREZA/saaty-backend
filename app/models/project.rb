class Project < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 100 },uniqueness: { scope: :client,
    message: "is the same in that client" }
  validates :color, presence: true,length: { is: 6 }
  validates :budget_type, numericality: { only_integer: true },inclusion: { in: [0,1,2], message: "%{value} is not a valid range" }, allow_nil: true
  validates :status, numericality: { only_integer: true },inclusion: { in: [0,1], message: "%{value} is not a valid range" }
  belongs_to :user, counter_cache: :projects_count
  belongs_to :client, counter_cache: :projects_count
  has_many :times, class_name: "Saat", foreign_key: "project_id", dependent: :delete_all
end
