require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    let(:user) { build(:user) }

    context '必要な情報が全て入力されている場合' do
      it 'ユーザー新規登録が成功すること' do
        expect(user).to be_valid
      end
    end

    context '名前が入力されていない場合' do
      it 'ユーザー新規登録が失敗すること' do
        user.name = nil
        expect(user).to_not be_valid
        expect(user.errors.details[:name][0][:error]).to eq :blank
      end
    end

    context '名前の長さが31文字以上の場合' do
      it 'ユーザー新規登録が失敗すること' do
        user.name = 'a' * 31
        expect(user).to_not be_valid
        expect(user.errors.details[:name][0][:error]).to eq :too_long
      end
    end

    context 'メールアドレスが入力されていない場合' do
      it 'ユーザー新規登録が失敗すること' do
        user.email = nil
        expect(user).to_not be_valid
        expect(user.errors.details[:email][0][:error]).to eq :blank
      end
    end

    context 'メールアドレスが256文字以上の場合' do
      it 'ユーザー新規登録が失敗すること' do
        user.email = 'a' * 244 + '@example.com'
        expect(user).to_not be_valid
        expect(user.errors.details[:email][0][:error]).to eq :too_long
      end
    end

    context 'メールアドレスが不正な形式の場合' do
      it 'ユーザー新規登録が失敗すること' do
        user.email = 'invalid-email'
        expect(user).to_not be_valid
        expect(user.errors.details[:email][0][:error]).to eq :invalid
      end
    end

    context 'メールアドレスが既に存在する場合' do
      it 'ユーザー新規登録が失敗すること' do
        create(:user, email: 'duplicate@example.com')
        user.email = 'duplicate@example.com'
        expect(user).to_not be_valid
        expect(user.errors.details[:email][0][:error]).to eq :taken
      end
    end
  end
end
