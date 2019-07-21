FactoryGirl.define do
  factory :novel do
    id 1
    title "noveltitle"
    catchphrase "novelcatchphrase"
    outline "noveloutline"
    keyword_one ""
    keyword_two ""
    keyword_three ""
    keyword_four ""
    keyword_five ""
    association :user, factory: :user
    association :genre, factory: :genre
  end
  
  factory :other_user_novel, class: Novel do
    id 2
    title "other"
    outline "other"
    catchphrase "other"
    keyword_one ""
    keyword_two ""
    keyword_three ""
    keyword_four ""
    keyword_five ""
    association :genre, factory: :genre
    association :user, factory: :other_user
  end
  
  factory :invalid_novel, class: Novel do
    id 3
    title ""
    outline ""
    catchphrase "novel catchphrase"
    keyword_one ""
    keyword_two ""
    keyword_three ""
    keyword_four ""
    keyword_five ""
    association :genre, factory: :genre
    association :user, factory: :user
  end
  
  factory :other_novel, class: Novel do
    id 4
    title "other_title"
    outline "other_outline"
    catchphrase "other_catchphrase"
    keyword_one ""
    keyword_two ""
    keyword_three ""
    keyword_four ""
    keyword_five ""
    association :genre, factory: :genre
    association :user, factory: :user
  end
  
end