FactoryGirl.define do
  factory :user do
    username "user1"
    password "123456"
    id 1
    # sequence :goal do
#       FactoryGirl.create(:goal)
#     end
  end
end
