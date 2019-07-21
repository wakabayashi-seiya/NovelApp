FactoryGirl.define do
  factory :user do
    id 1
    name  "tanaka_waka"
    email "example@gmail.com" 
    password "reaction"
    password_confirmation "reaction"  
    admin true
    activated true
    activated_at  Time.zone.now 
    field "head"
  end
  
  factory :other_user, class: User do
    id 2
    name  "charry_bottom"
    email "count@example.ne.jp" 
    password "reaction"
    password_confirmation "reaction"  
    admin true
    activated true
    activated_at  Time.zone.now 
    field "body"
  end
  
   factory :invalid_user, class: User do
    id 3
    name  " "
    email "reaction@example.com" 
    password "reaction"
    password_confirmation "reaction"  
    admin true
    activated true
    activated_at  Time.zone.now 
    field "foot"
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