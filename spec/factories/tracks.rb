# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :track do
    name "MyString"
    artist "MyString"
    spotify_id "MyString"
    order 1
    user_id 1
    playlist_id 1
  end
end
