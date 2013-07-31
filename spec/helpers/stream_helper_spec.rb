require 'spec_helper'


describe StreamHelper do

	class DummyClass
	end

	before(:all) do
	  @dummy_class = DummyClass.new
	  @dummy_class.extend(StreamHelper)
	end

	it "#fetch_total_listeners should not return nil" do
		@dummy_class.fetch_total_listeners.should_not be_nil
	end

end