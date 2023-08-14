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
end
