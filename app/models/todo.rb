# details          text
# due              date
# position         integer             null(false)
# priority         integer             null(false)
# title            string              null(false)
class Todo < ApplicationRecord
  validates :position, presence: true

  validate :due_date_today_or_further, on: :create
  validates :priority, presence: true, inclusion: { in: [1, 2, 3, 4] }
  validates :title, presence: true

  private

  def due_date_today_or_further
    return true if due.nil?
    errors.add(:due, "can't be less than today") if due < Date.today
  end
end
