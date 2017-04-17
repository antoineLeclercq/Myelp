require 'rails_helper'

describe User do
  it { is_expected.to validate_presence_of :full_name }
  it { is_expected.to validate_presence_of :city }
  it { is_expected.to validate_presence_of :state }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to have_secure_password }
end
