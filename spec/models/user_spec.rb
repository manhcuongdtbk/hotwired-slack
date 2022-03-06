require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:channels_users).dependent :destroy }
  it { is_expected.to have_many(:channels).through :channels_users }
  it { is_expected.to have_many(:messages).dependent :destroy }

  it { is_expected.to validate_presence_of :name }
end
