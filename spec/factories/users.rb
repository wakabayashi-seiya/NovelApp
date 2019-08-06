FactoryGirl.define do
  factory :user do
    id 1
    name  "tanaka_waka"
    email "example@gmail.com" 
    password "reaction"
    password_confirmation "reaction"  
    field "head"
    confirmed_at { Date.today }
  end
  
  factory :other_user, class: User do
    id 2
    name  "charry_bottom"
    email "count@example.ne.jp" 
    password "reaction"
    password_confirmation "reaction"  
    field "body"
    confirmed_at { Date.today }
  end
  
   factory :invalid_user, class: User do
    id 3
    name  " "
    email "reaction@example.com" 
    password "reaction"
    password_confirmation "reaction"  
    field "foot"
    confirmed_at { Date.today }
  end
  
  factory :ooo_user, class: User do
    id 3
    name  "rerererere"
    email "rerere@example.com" 
    password "reaction"
    password_confirmation "reaction" 
    field "foot"
  end
  
end