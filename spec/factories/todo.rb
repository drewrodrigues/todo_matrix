FactoryBot.define do
  factory :todo do
    details { "Some details go here" }
    due { Date.today }
    priority { rand(1..4) }
    sequence(:position)
    title { "Title goes here" }
  end
end
