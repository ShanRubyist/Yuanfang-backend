# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :api_v1_prompts, :class_name => 'Api::V1::Prompt'
  has_many :achieve_questions

  pay_customer default_payment_processor: ENV.fetch('PAYMENT_PROCESSOR').to_sym
end
