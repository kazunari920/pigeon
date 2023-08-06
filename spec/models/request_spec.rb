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

  describe '#can_send_to_message?' do
    context 'statusがacceptの場合' do
      let(:status) { 'accepted' }

      it 'trueを返す' do
        expect(request.can_send_to_message?(status)).to be true
      end
    end
    context 'statusがcompletedの場合' do
      let(:status) { 'completed' }

      it 'trueを返す' do
        expect(request.can_send_to_message?(status)).to be true
      end
    end
    context 'statusがofferedの場合' do
      let(:status) { 'offered' }

      it 'falseを返す' do
        expect(request.can_send_to_message?(status)).to be false
      end
    end
    context 'statusがdeclinedの場合' do
      let(:status) { 'declined' }

      it 'falseを返す' do
        expect(request.can_send_to_message?(status)).to be false
      end
    end
  end
end
