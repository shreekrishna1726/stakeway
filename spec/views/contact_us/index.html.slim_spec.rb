require 'rails_helper'

RSpec.describe "contact_us/index", type: :view do
  before(:each) do
    assign(:contact_us, [
      ContactU.create!(
        :title => "Title",
        :message => "MyText",
        :name => "Name",
        :email => "Email"
      ),
      ContactU.create!(
        :title => "Title",
        :message => "MyText",
        :name => "Name",
        :email => "Email"
      )
    ])
  end

  it "renders a list of contact_us" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
