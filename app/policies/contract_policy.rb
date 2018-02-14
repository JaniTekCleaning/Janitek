class ContractPolicy < ApplicationPolicy
  def index?
    user.class==Staff
  end

  def show?
    user.class==Staff || (user.buildings.include? record.building)
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