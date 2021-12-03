class MesurementsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'mesurements'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end