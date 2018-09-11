# details          text
# due              date
# position         integer             null(false)
# priority         integer             null(false)
# title            string              null(false)
class Todo < ApplicationRecord
  include Positionable
  after_save :sort_positions

  validate :due_date_today_or_further, on: :create
  validates :position, presence: true, 
    numericality: { greater_than_or_equal_to: 0 }
  validates :priority, presence: true, inclusion: { in: [1, 2, 3, 4] }
  validates :title, presence: true

  private

  def due_date_today_or_further
    return true if due.nil?
    errors.add(:due, "can't be less than today") if due < Date.today
  end
end
