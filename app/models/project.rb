class Project < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 100 },uniqueness: { scope: :client,
    message: "is the same in that client" }
  validates :color, presence: true,length: { is: 6 }
  belongs_to :user, counter_cache: :projects_count
  belongs_to :client, counter_cache: :projects_count
  has_many :times, class_name: "Saat", foreign_key: "project_id", dependent: :delete_all
end
