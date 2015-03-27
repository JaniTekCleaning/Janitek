class TrackingMailer < ActionMailer::Base
  default from: ENV["CONTACT_EMAIL"]

  def viewed_contract(member)
    @member=member
    target=member.client.staff.nil? ? ENV["CONTACT_EMAIL"] : member.client.staff.email
    mail(to:target, subject:member.full_name+ "has reviewed contract")
  end

  def viewed_schedule(member)
    @member=member
    target=member.client.staff.nil? ? ENV["CONTACT_EMAIL"] : member.client.staff.email
    mail(to:target, subject:member.full_name+ "has reviewed task schedule")
  end

  def edited_hotbutton(member)
    @member=member
    target=member.client.staff.nil? ? ENV["CONTACT_EMAIL"] : member.client.staff.email
    mail(to:target, subject:member.full_name+ "has edited hot button list")
  end
end
