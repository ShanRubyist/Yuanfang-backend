require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'should respond to #email' do
    expect(FactoryBot.build(:user)).to respond_to(:email)
  end

  it 'is invalid with dup user' do
    user = @user.dup
    expect(user).not_to be_valid
  end
end
