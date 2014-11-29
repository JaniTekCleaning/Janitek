class ContactPolicy < ApplicationPolicy
  def new?
    user.class==Member
  end
  def create?
    user.class==Member
  end
end