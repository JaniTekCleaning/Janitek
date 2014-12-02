class ContactMailer < ActionMailer::Base
  default from: "from@example.com"

  def contact_message(contact)
    @contact=contact
    @member=contact.member
    mail(to:ENV["CONTACT_EMAIL"], subject:"Message From: "+contact.member.full_name)
  end
end
