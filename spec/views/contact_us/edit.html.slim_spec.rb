require 'rails_helper'

RSpec.describe "contact_us/edit", type: :view do
  before(:each) do
    @contact_u = assign(:contact_u, ContactU.create!(
      :title => "MyString",
      :message => "MyText",
      :name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit contact_u form" do
    render

    assert_select "form[action=?][method=?]", contact_u_path(@contact_u), "post" do

      assert_select "input[name=?]", "contact_u[title]"

      assert_select "textarea[name=?]", "contact_u[message]"

      assert_select "input[name=?]", "contact_u[name]"

      assert_select "input[name=?]", "contact_u[email]"
    end
  end
end
