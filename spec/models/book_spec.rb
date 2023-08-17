require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { instance_double('Book') }

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
      before do
        allow(book).to receive(:published).and_return(false)
        allow(book).to receive(:publish!).and_return(true)
      end

      it 'trueを返す' do
        expect(subject).to be true
      end
    end
  end

  describe '.recently_added'
  subject { book.recently_added(n) }

  context '最近追加された書籍がn冊以上ある場合' do
    let!(:book) { create(:book) }
  end

end
