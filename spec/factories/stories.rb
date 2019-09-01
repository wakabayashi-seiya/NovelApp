FactoryGirl.define do
  factory :story do
    id 1
    title "title"
    text "text"
    association :novel, factory: :novel
  end

  factory :invalid_story, class: Story do
    id 2
    title ""
    text ""
    association :novel, factory: :novel
  end

  factory :other_novel_story, class: Story do
    id 3
    title "other_title"
    text "other_text"
    association :novel, factory: :other_novel
  end

  factory :other_user_novel_story, class: Story do
    id 4
    title "other_user_title"
    text "other_user_text"
    association :novel, factory: :other_user_novel
  end
end
