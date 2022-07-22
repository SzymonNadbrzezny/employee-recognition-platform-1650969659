module Admins
  class KudosController < AdminsController
    def index
      render :index, locals: { kudos: Kudo.includes(:receiver, :giver, :company_value).all }
    end

    def show
      render :show, locals: { kudo: kudo }
    end

    def destroy
      kudo.destroy
      redirect_to admins_kudos_url, notice: 'Kudo was successfully destroyed.'
    end

    private

    def kudo
      @kudo ||= Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
    end
  end
end
