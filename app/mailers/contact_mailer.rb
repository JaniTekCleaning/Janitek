class ContactMailer < ActionMailer::Base
  default from: ENV["CONTACT_EMAIL"]

  def contact_message(contact)
    @contact=contact
    @member=contact.member
    target=@member.client.staff.nil? ? ENV["CONTACT_EMAIL"] : @member.client.staff.email
    mail(to:target, subject:"Message From: "+contact.member.full_name)
  end

  def service_request(fields, member)
    @fields=fields
    @member=member
    @service_request=ServiceRequest.first
    target=@member.client.staff.nil? ? ENV["CONTACT_EMAIL"] : @member.client.staff.email
    mail(to:target, subject:"Service Request From: "+member.full_name)
  end
end
