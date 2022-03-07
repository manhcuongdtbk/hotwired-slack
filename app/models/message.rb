class Message < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  validates :body, presence: true

  after_create :process_mentions

  private

  def process_mentions
    UnreadsChannel.broadcast_to(channel, { mentions: mentioned_names, body: })
  end

  def mentioned_users
    # Users other than the one who created this message
    User.where(name: mentioned_names) - [user]
  end

  def mentioned_names
    body.scan(/@([\w-]+)/) # [[name1], [name2]]
        .flatten # [name1, name2]
  end
end
