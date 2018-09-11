module Positionable
  def sort_positions
    return unless todo_to_reposition
    todo_to_reposition.position = position + 1
    todo_to_reposition.save
  end

  def todo_to_reposition
    @todo_to_reposition ||= Todo.where(
      "position = ? AND priority = ? AND NOT id = ?",
      position, priority, id
    ).first
  end
end
