class Task < ApplicationRecord
  belongs_to :task_group

  validates :title, presence: true

  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
end
