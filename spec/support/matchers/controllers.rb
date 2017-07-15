# frozen_string_literal: true

RSpec::Matchers.define :user_signin_redirection do
  match do |response|
    expect(response).to have_http_status(302)
    expect(response).to have_http_status(:redirect)
    expect(response.header['Location']).to include new_user_session_path
  end
end
