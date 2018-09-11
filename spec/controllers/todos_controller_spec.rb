require "rails_helper"

RSpec.describe TodosController, type: :controller do
  let(:valid_params) { build_stubbed(:todo).attributes }

  describe "GET index" do
    it "renders all todos in JSON" do
      todos = create_list(:todo, 3)

      get :index

      expect(response.body).to eq(todos.to_json)
    end
  end

  describe "POST create" do
    context "valid params passed" do
      it "increments todos by 1" do
        expect do
          post :create, params: { todo: valid_params }
        end.to change(Todo, :count).by(1)
      end

      it "returns the todo in JSON" do
        post :create, params: { todo: valid_params }

        expect(response.body).to eq(Todo.last.to_json)
      end
    end

    context "invalid params passed" do
      it "returns error messages" do
        todo = build(:todo)
        todo.priority = 0
        todo.save

        post :create, params: { todo: todo.attributes }

        expect(response.body.include?(todo.errors.full_messages.to_json)).to be true
      end

      it "returns an error code" do
        todo = build(:todo)
        todo.priority = 0

        post :create, params: { todo: todo.attributes }

        expect(response.code).to eq(422.to_s)
      end
    end
  end

  describe "DELETE destroy" do
    context "correct id passed" do
      it "decrements todos by 1" do
        todo = create(:todo)

        expect do
          delete :destroy, params: { id: todo.id }
        end.to change(Todo, :count).by(-1)
      end

      it "returns a success code" do
        todo = create(:todo)

        delete :destroy, params: { id: todo.id }

        expect(response.code).to eq(200.to_s)
      end
    end

    context "invalid id passed" do
      it "returns an error" do
        delete :destroy, params: { id: 239_238 }

        expect(response.code).to eq(404.to_s)
      end
    end
  end
end
