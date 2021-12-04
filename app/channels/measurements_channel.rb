class MeasurementsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'measurements'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end