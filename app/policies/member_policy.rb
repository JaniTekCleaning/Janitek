class MemberPolicy < ApplicationPolicy
  def index?
    user.class==Staff
  end

  def show?
    user.class==Staff || user==record
  end

  def log?
    user.class==Staff
  end

  def edit?
    user.class==Staff || user==record
  end

  def update?
    user.class==Staff || user==record
  end

  def create?
    user.class==Staff
  end

  def new?
    user.class==Staff
  end

  def destroy?
    user.class==Staff
  end

  def permitted_attributes
    list=[:email,:first_name,:last_name,:avatar]
    if user.admin
      list<<[:password]
      list<<[:password_confirmation]
    end
    list
  end
end