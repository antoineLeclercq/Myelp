require 'rails_helper'

describe Business do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :street }
  it { is_expected.to validate_presence_of :city }
  it { is_expected.to validate_presence_of :state }
  it { is_expected.to validate_presence_of :zipcode }
  it { is_expected.to validate_numericality_of :zipcode }
  it { is_expected.to validate_presence_of :phone }
  it { is_expected.to validate_numericality_of :phone }
end
