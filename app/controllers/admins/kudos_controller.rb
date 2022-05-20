module Admins
  class KudosController < AdminsController
    # GET /kudos
    def index
      @kudos = Kudo.includes(:receiver, :giver, :company_value).all
    end

    # GET /kudos/1
    def show
      current_kudo
    end

    # DELETE /kudos/1
    def destroy
      current_kudo
      @kudo.destroy
      redirect_to admins_kudos_url, notice: 'Kudo was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def current_kudo
      @kudo = Kudo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kudo_params
      params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
    end
  end
end
