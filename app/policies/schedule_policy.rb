class SchedulePolicy < ApplicationPolicy
  def index?
    user.class==Staff
  end

  def show?
    user.class==Staff || user.client==record.client
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
end