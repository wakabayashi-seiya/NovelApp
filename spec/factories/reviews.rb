FactoryGirl.define do
  factory :review do
    id 1
    title "reviewtitle"
    text "reviewtext"
    association :user, factory: :user
    association :novel, factory: :novel
  end

  factory :other_user_review, class: Review do
    id 2
    title "otherusertitle"
    text "otherusertext"
    association :user, factory: :other_user
    association :novel, factory: :novel
  end

  factory :invalid_review, class: Review do
    id 3
    title ""
    text ""
    association :user, factory: :user
    association :novel, factory: :novel
  end

  factory :other_review, class: Review do
    id 4
    title "otherreviewtitle"
    text "otherreviewtext"
    association :user, factory: :user
    association :novel, factory: :novel
  end
end