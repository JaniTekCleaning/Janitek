class ActionLog < ActiveRecord::Base
  class UnrecognizedRequest < StandardError
  end

  belongs_to :user

  validates :controller, :presence=>true
  validates :action, :presence=>true
  validates :user, :presence=>true

  def request_recognized?
    begin
      description
    rescue
      return false
    end
    return true
  end

  def description
    # return controller.clasify.constantize unless controller=='devise/sessions'
    "May eventually enable this feature"
  end
end
