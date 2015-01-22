class TrackingMailer < ActionMailer::Base
  default from: ENV["CONTACT_EMAIL"]

  def viewed_contract(member)
    @member=member
    mail(to:ENV["CONTACT_EMAIL"], subject:member.full_name+ "has reviewed contract")
  end

  def viewed_schedule(member)
    @member=member
    mail(to:ENV["CONTACT_EMAIL"], subject:member.full_name+ "has reviewed task schedule")
  end
end
