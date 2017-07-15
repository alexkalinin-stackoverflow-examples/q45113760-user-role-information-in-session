#frozen_string_literal: true

FactoryGirl.define do
  factory(:role) do
    name 'some role'

    factory(:reader_role){ name 'reader'}
    factory(:writer_role){ name 'writer'}
    factory(:admin_role){ name 'admin'}
  end
end
