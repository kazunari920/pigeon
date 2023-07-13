# frozen_string_literal: true

module Users
  class ConfirmationsController < Devise::ConfirmationsController
    # GET /resource/confirmation/new
    # def new
    #   super
    # end

    def create
      super do |resource|
        flash[:notice] = '確認メールが送信されました。' if successfully_sent?(resource)
      end
    end

    def show
      super do |resource|
        sign_in(resource) if resource.errors.empty?
      end
    end
    # protected

    # The path used after resending confirmation instructions.
    # def after_resending_confirmation_instructions_path_for(resource_name)
    #   super(resource_name)
    # end

    # The path used after confirmation.
    # def after_confirmation_path_for(resource_name, resource)
    #   super(resource_name, resource)
    # end
  end
end
