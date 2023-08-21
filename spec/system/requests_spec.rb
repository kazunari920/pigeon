require 'rails_helper'

RSpec.describe "Requests", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenarios ' ユーザーが新しいリクエストを作成する ' do
    user = create(:user)

    visit root_path
    click_link 'ログイン/登録'
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password
  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
