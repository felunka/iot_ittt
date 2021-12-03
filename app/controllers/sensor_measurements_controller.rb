class SensorMeasurementsController < ApplicationController
  def index
    @sensor = Sensor.find params[:sensor_id]
  end
end
