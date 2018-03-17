require 'rails_helper'

RSpec.describe "contact_us/new", type: :view do
  before(:each) do
    assign(:contact_u, ContactU.new(
      :title => "MyString",
      :message => "MyText",
      :name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders new contact_u form" do
    render

    assert_select "form[action=?][method=?]", contact_us_path, "post" do

      assert_select "input[name=?]", "contact_u[title]"

      assert_select "textarea[name=?]", "contact_u[message]"

      assert_select "input[name=?]", "contact_u[name]"

      assert_select "input[name=?]", "contact_u[email]"
    end
  end
end
