require 'rails_helper'

describe User do
  describe '#valid_password?' do
    let(:user) { FactoryGirl.create :user, password: 'password1!' }

    it 'returns flase when provided the wrong password' do
      expect(user.valid_password?('nonsense')).to eq(false)
    end

    it 'returns true when provided the correct password' do
      expect(user.valid_password?('password1!')).to eq(true)
    end
  end

  describe '#password=' do
    it 'sets the password digest to a valid encrypted hash' do
      user = User.new
      expect(user.password_digest).to eq(nil)
      user.password = "password"
      expect(BCrypt::Password).to be_valid_hash(user.password_digest)
    end
  end
end
