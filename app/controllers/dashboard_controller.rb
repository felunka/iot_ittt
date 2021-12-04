class DashboardController < ApplicationController
  def show
    @sensors = Sensor.all
  end
end
