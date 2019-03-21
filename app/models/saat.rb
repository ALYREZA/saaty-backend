class Saat < ApplicationRecord
  belongs_to :user
  belongs_to :project, counter_cache: :saats_count
  belongs_to :client, counter_cache: :projects_count

  scope :like, ->(field, value) { where arel_table[field].matches("%#{value}%") }

end
