describe "Messages API" do
  it 'sends a list of messages' do
    # FactoryGirl.create_list(:message, 10)

    get "https://api-c2-dev.captira.com/search/ken"

    json = JSON.parse(response.body)

    p json

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of messages are returned
  end
end