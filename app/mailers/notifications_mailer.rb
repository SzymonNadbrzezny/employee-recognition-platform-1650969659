class NotificationsMailer < ApplicationMailer
  def notify_of_delivery
    @employee = params[:employee]
    @order = params[:order]
    mail(to: @employee.email, subject: 'Confirmation of order delivery')
  end
end
