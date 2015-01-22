class ContactMailer < ActionMailer::Base
  default from: ENV["CONTACT_EMAIL"]

  def contact_message(contact)
    @contact=contact
    @member=contact.member
    mail(to:ENV["CONTACT_EMAIL"], subject:"Message From: "+contact.member.full_name)
  end
end
