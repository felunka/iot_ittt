class SensorsController < ApplicationController
  def index
    @sensors = Sensor.all
  end

  def new
    @sensor = Sensor.new
  end

  def create
    @sensor = Sensor.new params.require(:sensor).permit(:name, :sensor_type, :topic, :url, :interval, :json_path)
    if @sensor.save
      flash[:success] = 'Sensor created'
      redirect_to action: 'index'
    else
      render :new
    end
  end

  def edit
    @sensor = Sensor.find_by params.permit(:id)
  end

  def update
    @sensor = Sensor.find_by params.permit(:id)
    if @sensor.update params.require(:sensor).permit(:name, :sensor_type, :topic, :url, :interval, :json_path)
      flash[:success] = 'Sensor updated'
      redirect_to action: 'index'
    else
      render :edit
    end
  end

  def destroy
    Sensor.find_by(params.permit(:id)).destroy
    flash[:danger] = 'Sensor deleted'
    redirect_to action: 'index'
  end
end
