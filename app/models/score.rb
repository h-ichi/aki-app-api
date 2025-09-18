class Score < ApplicationRecord
  validates :level, presence: true
  validates :remaining_time, presence: true
  validates :played_on, presence: true
end
