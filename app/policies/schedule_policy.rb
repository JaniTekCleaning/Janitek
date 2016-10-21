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
    create?
  end

  def destroy?
    create?
  end

  def update?
    create?
  end

  def edit?
    create?
  end
end 