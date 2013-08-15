require 'faker'

FactoryGirl.define do
	factory :index_info do |p|
		p.content { Faker::Lorem.paragraph }
		p.title { Faker::Name.name }
		p.display { true }
	end
end