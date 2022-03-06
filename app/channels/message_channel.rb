class MessageChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams

    @channels_user = current_user.channels_users.find_by(channel_id: params[:id])
    @channel = @channels_user.channel

    stream_for @channel
  end

  def unsubscribed
    stop_all_streams
  end

  def touch
    @channels_user.touch(:last_read_at)
  end
end
