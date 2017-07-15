#frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    password '123123123'

    trait :empty do
      email FFaker::Internet.email
      roles []
    end

    trait :reader do
      sequence(:email){ |n| "reader#{n}@mail.com"}
      roles { [ create(:reader_role) ] }
    end

    trait :writer do
      sequence(:email){ |n| "writer#{n}@mail.com"}
      roles { [ create(:writer_role) ] }
    end

    trait :admin do
      sequence(:email){ |n| "admin#{n}@mail.com"}
      roles { [ create(:admin_role) ] }
    end

    factory(:empty_user) { empty }
    factory(:reader_user) { reader }
    factory(:writer_user) { writer }
    factory(:admin_user) { admin }
  end
end
