# frozen_string_literal: true

module Photographers
  class ConfirmationsController < Devise::ConfirmationsController
    # GET /resource/confirmation/new
    # def new
    #   super
    # end

    def create
      super do |resource|
        if successfully_sent?(resource)
          flash[:notice] = '確認メールが送信されました。'
        end
      end
    end

    def show
      super do |resource|
        if resource.errors.empty?
          sign_in(resource)
        end
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
