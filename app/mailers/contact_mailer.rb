class ContactMailer < ActionMailer::Base
  default from: ENV["CONTACT_EMAIL"]

  def contact_message(contact)
    @contact=contact
    @member=contact.member
    mail(to:ENV["CONTACT_EMAIL"], subject:"Message From: "+contact.member.full_name)
  end

  def service_request(service_request, submission, member)
    @fields=service_request.fields
    @submission=submission
    @member=member
    mail(to:ENV["CONTACT_EMAIL"], subject:"Service Request From: "+member.full_name)
  end
end
