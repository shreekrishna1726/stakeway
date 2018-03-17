require 'rails_helper'

RSpec.describe "ContactUs", type: :request do
  describe "GET /contact_us" do
    it "works! (now write some real specs)" do
      get contact_us_path
      expect(response).to have_http_status(200)
    end
  end
end
