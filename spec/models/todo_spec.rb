require 'rails_helper'

RSpec.describe Todo, type: :model do
  # TODO: create expect_validity gem
  # expect_valid... expect_invalid
  it "has a valid base factory" do
    todo = build_stubbed(:todo)

    expect(todo).to be_valid
  end

  describe "details" do
    it "can be empty" do
      todo = build_stubbed(:todo)

      todo.details = nil

      expect(todo).to be_valid
    end
  end

  describe "due" do
    it "can be empty" do
      todo = build_stubbed(:todo)

      todo.due = nil

      expect(todo).to be_valid
    end

    it "can't be in the past" do
      todo = build_stubbed(:todo)

      todo.due = Date.today - 1 

      expect(todo).to_not be_valid
    end
  end
  
  describe "position" do
    it "must be present" do
      todo = build_stubbed(:todo)

      todo.position = nil

      expect(todo).to_not be_valid
    end
  end

  describe "priority" do
    it "must be present" do
      todo = build_stubbed(:todo)

      todo.position = nil

      expect(todo).to_not be_valid
    end

    it "allows priorities 1-4" do
      todo = build_stubbed(:todo)

      (1..4).each do |i|
        todo.priority = i
        expect(todo).to be_valid
      end
    end

    it "doesn't allow priority's other than 1-4" do
      todo = build_stubbed(:todo)

      %w[0 5 100].each do |i|
        todo.priority = i
        expect(todo).to_not be_valid
      end
    end
  end

  describe "title" do
    it "must be present" do
      todo = build_stubbed(:todo)

      todo.title = nil

      expect(todo).to_not be_valid
    end
  end
end
