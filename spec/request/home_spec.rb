require "rails_helper"

describe "Home", type: :request do
  it "tests home" do
    get home_path
    #expect(body_json).to eq({ 'message' => 'Uhul!' })
    #expect(response).to redirect_to(controler_path)
    expect(response).to have_http_status(200)
  end

end