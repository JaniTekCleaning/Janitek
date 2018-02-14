class BuildingPolicy < ApplicationPolicy
  def index?
    user.class==Staff
  end

  def show?
    user.class==Staff || (user.buildings.include? record)
  end

  def create?
    user.class==Staff
  end

  def new?
    user.class==Staff
  end

  def update?
    show?
  end

  def update_janitorial_lead?
    user.class==Staff
  end

  def edit?
    update?
  end

  def destroy?
    user.class==Staff
  end

  def edit_hotbutton?
    show?
  end

  def update_hotbutton?
    show?
  end
end