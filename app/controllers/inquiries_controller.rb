class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(contact_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver
      flash[:inquiry_success] = 'お問い合わせを受け付けました'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:inquiry).permit(:name, :message)
  end
end
