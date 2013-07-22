require 'faker'

FactoryGirl.define do
	factory :podcast do |p|
		p.artistname { Faker::Name.name }
		p.feedurl { Faker::Internet.domain_name }
		p.flattrhandle { Faker::Name.name }
		p.hoersuppeslug { Faker::Name.name }
		p.name { Faker::Name.name }
		p.slugintern { Faker::Name.name }
		p.twitterhandle { Faker::Name.name }
		p.url { Faker::Internet.domain_name }
		p.description { Faker::Lorem.paragraph }
		p.adnhandle { Faker::Name.name }
	end
end