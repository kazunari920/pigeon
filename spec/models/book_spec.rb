require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { described_class.new }

  describe 'scopes' do
    describe '.published' do
      subject { described_class.published }
      let!(:published_book) { create(:book, published: true) }
      let!(:unpublished_book) { create(:book, published: false) }

      context '公開されている書籍が見つかった場合' do
        it '公開されている書籍を返す' do
          expect(subject).to contain_exactly(published_book)
        end
      end
    end

    describe '.by_author' do
      subject { described_class.by_author(author_name) }
      let!(:correct_book) { create(:book, author: '田中太郎') }
      let!(:incorrect_book) { create(:book, author: '鈴木太郎') }

      context '指定した著者の書籍が存在する場合' do
        let!(:author_name) { '田中太郎' }
        it '指定した著者の書籍を返す' do
          expect(subject).to contain_exactly(correct_book)
        end
      end
    end
  end

  describe '#publish!' do
    subject { book.publish! }

    context '公開される場合' do
      let!(:book) { create(:book, published: false) }

      it 'trueを返す' do
        expect(subject).to be true
      end
    end
  end

  describe '.recently_added' do
    subject { described_class.recently_added(num) }

    let!(:book1) { create(:book, created_at: '2021-01-01 00:00:00') }
    let!(:book2) { create(:book, created_at: '2022-01-01 00:00:00') }
    let!(:book3) { create(:book, created_at: '2023-01-01 00:00:00') }

    context '最近追加された書籍を取得する場合' do
      let!(:num) { 3 }
      it '新しい順に指定された数を取得する' do
        expect(subject).to eq [book3, book2, book1]
      end
    end
  end
end
