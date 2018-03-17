require 'rails_helper'

RSpec.describe "contact_us/show", type: :view do
  before(:each) do
    @contact_u = assign(:contact_u, ContactU.create!(
      :title => "Title",
      :message => "MyText",
      :name => "Name",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
  end
end
