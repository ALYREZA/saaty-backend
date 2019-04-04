class Saat < ApplicationRecord
  belongs_to :user
  belongs_to :project, counter_cache: :saats_count
  belongs_to :client, counter_cache: :projects_count

  scope :like, ->(field, value) { where arel_table[field].matches("%#{value}%") }
  def checkMe
    if user.isExpired
        errors.add(:base, "Your Free Trial Finished") if user.plan === 0
        errors.add(:base, "your account has been expire for about #{user.daysFromExpire} days ago")
        throw(:abort, "something went wrong")
    end
  end
end
