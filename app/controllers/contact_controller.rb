class ContactController < ApplicationController
  # add_breadcrumb "Home", :root_path
  # add_breadcrumb "Contact Us", :contact_us_path

  def new
    authorize Contact
    @contact=Contact.new
  end
  def create
    authorize Contact
    contact_params=params.require(:contact).permit(:content)
    @contact=Contact.new(contact_params.merge({:member=>current_user}))
    if @contact.valid?
      ContactMailer.contact_message(@contact).deliver_now
      redirect_to root_url, notice: "Message sent! Thank you for contacting us."
    else
      render "new"
    end
  end
end
