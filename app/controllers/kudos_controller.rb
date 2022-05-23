class KudosController < ApplicationController
  before_action :authenticate_employee!

  # GET /kudos
  def index
    render :index, locals: { kudos: Kudo.includes(:receiver, :giver, :company_value).all }
  end

  # GET /kudos/1
  def show
    render :show, locals: { kudo: kudo }
  end

  # GET /kudos/new
  def new
    render :new, locals: { kudo: Kudo.new }
  end

  # GET /kudos/1/edit
  def edit
    render :edit, locals: { kudo: kudo }
  end

  # POST /kudos
  def create
    @kudo = Kudo.new(kudo_params)
    kudo.giver = current_employee
    current_employee.decrement(:number_of_available_kudos).save if current_employee.number_of_available_kudos.positive?
    if kudo.save
      redirect_to kudos_path, notice: 'Kudo was successfully created.'
    else
      render :new, locals: { kudo: kudo }
    end
  end

  # PATCH/PUT /kudos/1
  def update
    if kudo.update(kudo_params)
      redirect_to kudos_path, notice: 'Kudo was successfully updated.'
    else
      render :edit, locals: { kudo: kudo }
    end
  end

  # DELETE /kudos/1
  def destroy
    kudo.destroy
    redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def kudo
    @kudo ||= Kudo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def kudo_params
    params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
  end
end
