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

  describe '#record_bad_login!' do
    let(:user) { FactoryGirl.create(:user) }

    it 'increments the bad login attempts count' do
      expect do
        user.record_bad_login!
      end.to change { user.failed_login_attempts }.from(0).to(1)
    end

    it 'sets the account lock out timestamp to current time on 4th attempt' do
      expect do
        4.times { user.record_bad_login! }
      end.to change { user.locked_out_timestamp }.from(nil).to(Date.today)
    end
  end

  describe '#locked_out?' do
    it 'returns false if locked_out_timestamp is not set' do
      user = FactoryGirl.build(:user)
      expect(user).to_not be_locked_out
    end

    it 'returns false if more than 1 day passed since locked out' do
      user = FactoryGirl.build(:user, locked_out_timestamp: Date.yesterday - 1.day)
      expect(user).to_not be_locked_out
    end

    it 'returns true if less than 1 day passed since locked out' do
      user = FactoryGirl.build(:user, locked_out_timestamp: Date.today)
      expect(user).to be_locked_out
    end
  end
end
