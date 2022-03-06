module Dashboard
  class ChannelsUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_channel

    def create
      @channel.channels_users.find_or_create_by(user: current_user)
      redirect_to dashboard_channel_url(@channel), notice: "Welcome to #{@channel.name}"
    end

    def destroy
      @channel.channels_users.where(user: current_user).destroy_all
      redirect_to dashboard_root_url, notice: "Leave #{@channel.name} successfully"
    end

    private

    def set_channel
      @channel = Channel.find(params[:channel_id])
    end
  end
end
