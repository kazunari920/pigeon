require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:photographer) { instance_double('Photographer') }
  let(:request) { described_class.new }

  describe '#accept' do
    context 'requestがphotographerにacceptされる場合' do
      before do
        allow(request).to receive(:can_be_accepted_by?).and_return(true)
        allow(request).to receive(:accepted!).and_return(true)
      end

      it 'acceptされた時trueを返す' do
        expect(request.accept(photographer)).to be true
      end

      it '承認された際accepted!メソッドが呼ばれる' do
        expect(request).to receive(:accepted!)
        request.accept(photographer)
      end

      it 'can_be_accepted_by?メソッドが呼ばれる' do
        expect(request).to receive(:can_be_accepted_by?)
        request.accept(photographer)
      end
    end

    context 'requestがacceptに失敗した場合' do
      before do
        allow(request).to receive(:can_be_accepted_by?).and_return(false)
      end

      it 'acceptに失敗した時falseを返す' do
        expect(request.accept(photographer)).to be false
      end
    end
  end

  describe '#decline' do
    context 'requestがphotographerにdeclineされる場合' do
      before do
        allow(request).to receive(:can_be_declined_by?).and_return(true)
        allow(request).to receive(:declined!).and_return(true)
      end

      it 'declineされた時trueを返す' do
        expect(request.decline(photographer)).to be true
      end

      it 'declineされた際declined!メソッドが呼ばれる' do
        expect(request).to receive(:declined!)
        request.decline(photographer)
      end

      it 'can_be_declined_by?メソッドが呼ばれる' do
        expect(request).to receive(:can_be_declined_by?)
        request.decline(photographer)
      end
    end
    context 'requestがdeclineに失敗した場合' do
      before do
        allow(request).to receive(:can_be_declined_by?).and_return(false)
        allow(request).to receive(:declined!).and_return(false)
      end
      it 'declineに失敗した時falseを返す' do
        expect(request.decline(photographer)).to be false
      end
    end
  end

  describe '#complete' do
    context 'requestがphotographerにcompleteされる場合' do
      before do
        allow(request).to receive(:can_be_completed_by?).and_return(true)
        allow(request).to receive(:completed!).and_return(true)
      end

      it 'completeされた時trueを返す' do
        expect(request.complete(photographer)).to be true
      end
      it 'completeされた際completed!メソッドが呼ばれる' do
        expect(request).to receive(:completed!)
        request.complete(photographer)
      end
      it 'can_be_completed_by?メソッドが呼ばれる' do
        expect(request).to receive(:can_be_completed_by?)
        request.complete(photographer)
      end
    end
    context 'requestがcompleteに失敗した場合' do
      before do
        allow(request).to receive(:can_be_completed_by?).and_return(false)
        allow(request).to receive(:completed!).and_return(false)
      end
      it 'completeに失敗した時falseを返す' do
        expect(request.complete(photographer)).to be false
      end
    end
  end

  # 一番最初に書いたもの
  describe '#can_send_to_message?' do
    context 'acceptedの場合' do
      let(:request) { Request.new(status: 'accepted') }
      it 'trueを返す' do
        expect(request.can_send_to_message?).to be true
      end
    end

    context 'completedの場合' do
      let(:request) { Request.new(status: 'completed') }
      it 'trueを返す' do
        expect(request.can_send_to_message?).to be true
      end
    end

    context 'declinedの場合' do
      let(:request) { Request.new(status: 'declined') }
      it 'falseを返す' do
        expect(request.can_send_to_message?).to be false
      end
    end

    context 'offeredの場合' do
      let(:request) { Request.new(status: 'offered') }
      it 'falseを返す' do
        expect(request.can_send_to_message?).to be false
      end
    end
  end

  # 以下教えてもらった方法で書き直したもの
  # describe '#can_send_to_message?' do
  #   subject { request.can_send_to_message? }
  #   before do
  #     allow(request).to receive(:accepted?).and_return(is_accepted)
  #   end

  #   context 'acceptedの場合' do
  #     let(:is_accepted) { true }
  #     it 'trueを返す' do
  #       expect(subject).to be true
  #     end
  #   end

  #   context 'acceptedでない場合' do
  #     let(:is_accepted) { false }
  #     before do
  #       allow(request).to receive(:completed?).and_return(is_completed)
  #     end

  #     context 'completedの場合' do
  #       let(:is_completed) { true }
  #       it 'trueを返す' do
  #         expect(subject).to be true
  #       end
  #     end

  #     context 'completedでない場合' do
  #       let(:is_completed) { false }
  #       it 'falseを返す' do
  #         expect(subject).to be false
  #       end
  #     end
  #   end
  # end

  describe '#can_be_accepted_by?' do
    subject { request.can_be_accepted_by?(photographer) }
    before do
      allow(request).to receive(:status).and_return(is_offered)
    end

    context 'statusがofferedでない場合' do
      let!(:is_offered) { '' }
      it 'falseを返す' do
        expect(subject).to be false
      end
    end

    context 'statusがofferedの場合' do
      before do
        allow(request).to receive(:photographer_id).and_return(1)
      end
      let!(:is_offered) { 'offered' }

      context 'photographerのidが一致する場合' do
        let!(:photographer) { instance_double('Photographer', id: 1) }
        it 'trueを返す' do
          expect(subject).to be true
        end
      end

      context 'photographerのidが一致しない場合' do
        let!(:other_photographer) { instance_double('Photographer', id: 10) }
        subject { request.can_be_accepted_by?(other_photographer) }
        it 'falseを返す' do
          expect(subject).to be false
        end
      end
    end
  end

  describe '#accessed_by?' do
    subject { request.accessed_by?(user, photographer) }
    let!(:user) { create(:user) }
    let!(:photographer) { create(:photographer) }

    context 'ユーザーがアクセスする場合' do
      # この部分がfalseの場合、photographerかどうかの判定に移行すると考えたので
      # 'falseを返す'を削除
      let(:request) { create(:request, user: user) }

      it 'trueを返す' do
        expect(subject).to be true
      end
    end

    context 'フォトグラファーがアクセスする場合' do
      # photographerに紐づいたリクエストを作成
      let(:request) { create(:request, photographer: photographer) }
      it 'trueを返す' do
        expect(subject).to be true
      end
    end

    context 'ユーザーでもフォトグラファーでもない場合' do
      # どちらにも紐づいていないrequestを作成
      let(:request) { create(:request) }

      it 'falseを返す' do
        expect(subject).to be false
      end
    end
    # 14:40 作業開始
    # 16:27 現在の形に
    # メソッドの評価順を考えてみて、分岐は３種類かなと考えたので、contextを変更しました
    # userがtrue→true return
    # userがfalseでphotographerがtrue→ true return
    # photographerがfalse→メソッドがfalse return
    # と考えました


  end
end
