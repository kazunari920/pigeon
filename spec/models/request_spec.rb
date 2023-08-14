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

  describe '#rspec_training1' do
    before do
      allow(request).to receive(:accepted?).and_return(is_accepted)
    end
    context 'acceptedの場合' do
      let(:is_accepted) { true }
      it 'trueを返す' do
        expect(request.rspec_training1).to be true
      end
    end
    context 'acceptedでない場合' do
      let(:is_accepted) { false }
      before do
        allow(request).to receive(:completed?).and_return(is_completed)
      end
      context 'completedの場合' do
        let(:is_completed) { true }
        it 'trueを返す' do
          expect(request.rspec_training1).to be true
        end
      end
      context 'completedでない場合' do
        let(:is_completed) { false }
        it 'falseを返す' do
          expect(request.rspec_training1).to be false
        end
      end
    end
  end

  describe '#rspec_training2' do
    context 'acceptedがfalseの場合' do
    end
    context 'acceptedがtrueの場合' do
      context 'declinedがfalseの場合' do
      end
      context 'declinedがtrueの場合' do
        context 'completedがfalseの場合' do
        end
        context 'completedがtrueの場合' do
        end
      end
    end
  end

  describe '#rspec_training3' do
    before do
      allow(request).to receive(:completed?).and_return(is_completed)
    end
    context 'completedがtrueの場合' do
      let(:is_completed) { true }
      it 'trueを返す' do
        expect(request.rspec_training3).to be true
      end
    end
    context 'completedがfalseの場合' do
      let(:is_completed) { false }
      before do
        allow(request).to receive(:accepted?).and_return(is_accepted)
      end
      context 'acceptedがfalseの場合' do
        let(:is_accepted) { false }
        it 'falseを返す' do
          expect(request.rspec_training3).to be false
        end
      end
      context 'acceptedがtrueの場合' do
        let(:is_accepted) { true }
        before do
          allow(request).to receive(:declined?).and_return(is_declined)
        end
        context 'declinedがfalseの場合' do
          let(:is_declined) { false }
          it 'falseを返す' do
            expect(request.rspec_training3).to be false
          end
        end
        context 'declinedがtrueの場合' do
          let(:is_declined) { true }
          it 'trueを返す' do
            expect(request.rspec_training3).to be true
          end
        end
      end
    end
  end

  describe 'scopes' do
    describe '.accepted' do
      let!(:accepted_request) { create(:request, status: 'accepted') }
      before do
        create(:request, status: 'offered')
        create(:request, status: 'declined')
        create(:request, status: 'completed')
      end

      it 'acceptedのrequestを探す' do
        expect(Request.accepted).to contain_exactly(accepted_request)
      end

    end

    describe '.newest' do
      let!(:first_request) { create(:request, created_at: '2021-01-01 00:00:00') }
      let!(:second_request) { create(:request, created_at: '2022-01-01 00:00:00') }
      let!(:third_request) { create(:request, created_at: '2023-01-01 00:00:00') }

      it '新しい順に並べる' do
        expect(Request.newest).to eq [third_request, second_request, first_request]
      end
    end

    describe '.search' do
      let!(:search_target) { create(:request, shooting_location: '東京') }
      before do
        create(:request, shooting_location: '北海道')
        create(:request, shooting_location: '沖縄')
      end

      it '東京を探す' do
        expect(Request.search('東京')).to contain_exactly(search_target)
      end
    end
  end

  describe '.search_by_shooting_location' do
    subject { described_class.search_by_shooting_location(search_word) }
    let!(:target_location) { create(:request, shooting_location: '東京') }
    let!(:wrong_location) { create(:request, shooting_location: '京都') }
    let!(:wrong_location2) { create(:request, shooting_location: '大阪') }

    context '検索ワードが存在しない場合' do
      let!(:search_word) { nil }
      it '全てのrequestを返す' do
        expect(subject).to contain_exactly(target_location, wrong_location, wrong_location2)
      end
    end
    context '検索ワードが存在した場合' do
      let!(:search_word) { '東京' }
      it '検索結果を返す' do
        expect(subject).to contain_exactly(target_location)
      end
    end
  end

  # 以下教えてもらった方法
  # describe '#can_send_to_message?' do
  #   let(:request) { Request.new }
  #   before do
  #     allow(request).to receive(:accepted?).and_return(is_accepted)
  #   end
  #   context 'acceptedの場合' do
  #     let(:is_accepted) { true }
  #     it 'trueを返す' do
  #       expect(request.can_send_to_message?).to be true
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
  #         expect(request.can_send_to_message?).to be true
  #       end
  #     end
  #     context 'completedでない場合' do
  #       let(:is_completed) { false }
  #       it 'falseを返す' do
  #         expect(request.can_send_to_message?).to be false
  #       end
  #     end
  #   end
  # end
end
