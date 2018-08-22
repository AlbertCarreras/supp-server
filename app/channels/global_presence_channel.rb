class GlobalPresenceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "presence_channel"
    # current_user.active_user = true
    # current_user.save
    # global_presence_channel.broadcast("presence_channel", {type: "DC_USER", user: current_user.id})
  end

  def unsubscribed
    # current_user.active_user = false
    # current_user.save
    # global_presence_channel.broadcast("presence_channel", {type: "DC_USER", user: current_user.id})
  end
end
