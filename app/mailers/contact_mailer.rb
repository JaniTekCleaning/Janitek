class ContactMailer < ActionMailer::Base
  default from: ENV["CONTACT_EMAIL"]

  def contact_message(contact)
    @contact=contact
    @member=contact.member
    target=@member.client.staff.nil? ? ENV["CONTACT_EMAIL"] : @member.client.staff.email
    mail(to:target, subject:"Message From: "+contact.member.full_name, from:contact.member.email)
  end

  def service_request(service_request, submission, member)
    @fields=service_request.fields
    @submission=submission
    @member=member
    target=@member.client.staff.nil? ? ENV["CONTACT_EMAIL"] : @member.client.staff.email
    mail(to:target, subject:"Service Request From: "+member.full_name, from:contact.member.email)
  end
end
