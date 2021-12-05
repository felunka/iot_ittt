class ItttsController < ApplicationController
  def index
    @ittts = Ittt.all
  end

  def new
    @ittt = Ittt.new
  end

  def create
    @ittt = Ittt.new permit(params)
    byebug
    if @ittt.save
      flash[:success] = 'Ittt created'
      redirect_to action: 'index'
    else
      render :new
    end
  end

  def edit
    @ittt = Ittt.find params[:id]
  end

  def update
    @ittt = Ittt.find_by params.permit(:id)
    if @ittt.update permit(params)
      flash[:success] = 'Ittt updated'
      redirect_to action: 'index'
    else
      render :edit
    end
  end

  def destroy
    Ittt.find_by(params.permit(:id)).destroy
    flash[:danger] = 'Ittt deleted'
    redirect_to action: 'index'
  end

  private

  def permit(params)
    params.require(:ittt).permit(
      :id,
      :name,
      :interval,
      ittt_conditions_attributes: [
        :id,
        :sensor_1_id,
        :operation,
        :sensor_2_id,
        :comparison_value,
        :_destroy
      ],
      ittt_actions_attributes: [
        :id,
        :topic,
        :message,
        :_destroy
      ]
    )
  end
end
