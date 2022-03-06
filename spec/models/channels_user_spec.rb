require 'rails_helper'

RSpec.describe ChannelsUser, type: :model do
  it { is_expected.to belong_to :channel }
  it { is_expected.to belong_to :user }
end
