FactoryGirl.define do
  factory :note do
    id 1
    title "notetitle"
    text "notetext"
    association :user, factory: :user
  end

  factory :other_user_note, class: Note do
    id 2
    title "otherusertitle"
    text "otherusertext"
    association :user, factory: :other_user
  end

  factory :invalid_note, class: Note do
    id 3
    title ""
    text ""
    association :user, factory: :user
  end

  factory :other_note, class: Note do
    id 4
    title "othernotetitle"
    text "othernotetext"
    association :user, factory: :user
  end
end