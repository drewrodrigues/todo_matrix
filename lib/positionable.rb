module Positionable
  def sort_positions
    return unless todo_to_reposition
    todo_to_reposition.position = self.position + 1
    todo_to_reposition.save
  end

  def todo_to_reposition 
    @todo ||= Todo.where(
      "position = ? AND priority = ? AND NOT id = ?", 
      self.position, self.priority, self.id).first
  end
end
