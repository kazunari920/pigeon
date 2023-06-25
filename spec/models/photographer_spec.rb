require 'rails_helper'

RSpec.describe Photographer, type: :model do
  describe 'フォトグラファー新規登録' do
    let(:photographer) { build(:photographer) }

    context '必要な情報が全て入力されている場合' do
      it 'フォトグラファー新規登録が成功すること' do
        expect(photographer).to be_valid
      end
    end

    context '名前が入力されていない場合' do
      it 'フォトグラファー新規登録が失敗すること' do
        photographer.name = nil
        expect(photographer).to_not be_valid
        expect(photographer.errors.details[:name][0][:error]).to eq :blank
      end
    end

    context '名前の長さが31文字以上の場合' do
      it 'フォトグラファー新規登録が失敗すること' do
        photographer.name = 'a' * 31
        expect(photographer).to_not be_valid
        expect(photographer.errors.details[:name][0][:error]).to eq :too_long
      end
    end

    context 'メールアドレスが入力されていない場合' do
      it 'フォトグラファー新規登録が失敗すること' do
        photographer.email = nil
        expect(photographer).to_not be_valid
        expect(photographer.errors.details[:email][0][:error]).to eq :blank
      end
    end

    context 'メールアドレスが256文字以上の場合' do
      it 'フォトグラファー新規登録が失敗すること' do
        photographer.email = 'a' * 244 + '@example.com'
        expect(photographer).to_not be_valid
        expect(photographer.errors.details[:email][0][:error]).to eq :too_long
      end
    end

    context 'メールアドレスが不正な形式の場合' do
      it 'フォトグラファー新規登録が失敗すること' do
        photographer.email = 'invalid-email'
        expect(photographer).to_not be_valid
        expect(photographer.errors.details[:email][0][:error]).to eq :invalid
      end
    end

    context 'メールアドレスが既に存在する場合' do
      it 'フォトグラファー新規登録が失敗すること' do
        create(:photographer, email: 'duplicate@example.com')
        photographer.email = 'duplicate@example.com'
        expect(photographer).to_not be_valid
        expect(photographer.errors.details[:email][0][:error]).to eq :taken
      end
    end
  end
end
