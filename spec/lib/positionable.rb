require 'rails_helper'
require 'positionable'

RSpec.describe Positionable do
  describe "#sort_positions" do
    context "when there are objects with >= position" do
      it "increments each objects position" do
        first_todo = create(:todo, priority: 1, position: 1)
        second_todo = create(:todo, priority: 1, position: 2)
        third_todo = create(:todo, priority: 1, position: 3)

        # skip callbacks since we call after_save on model
        second_todo.update_column(:position, 1)
        second_todo.sort_positions

        expect(first_todo.reload.position).to eq(2)
        expect(third_todo.reload.position).to eq(3)
      end
    end
  end

  describe "#todo_to_reposition" do
    context "when position isn't taken" do
      it "returns nil" do
        first_todo = create(:todo, priority: 1, position: 1)
        second_todo = create(:todo, priority: 1, position: 2)

        expect(first_todo.todo_to_reposition).to eq(nil)
      end
    end

    context "when position is taken" do
      it "doesn't get itself" do
        first_todo = create(:todo, priority: 1, position: 1)

        expect(first_todo.todo_to_reposition).to_not eq(first_todo)
      end

      it "gets todo with the same priority" do
        first_todo = create(:todo, priority: 1, position: 1)
        create(:todo, priority: 2, position: 2)
        create(:todo, priority: 1, position: 2)

        first_todo.position = 2

        expect(first_todo.todo_to_reposition.priority).to eq(first_todo.priority)
      end

      it "gets todo with the same position" do
        first_todo = create(:todo, priority: 1, position: 1)
        second_todo = create(:todo, priority: 1, position: 2)

        first_todo.position = 2

        expect(first_todo.todo_to_reposition.position).to eq(second_todo.position)
      end
    end
  end
end
