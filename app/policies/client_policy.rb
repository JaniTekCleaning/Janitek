class ClientPolicy < ApplicationPolicy
  def index?
    user.class==Staff
  end

  def show?
    user.class==Staff || user.client==record
  end

  def create?
    user.class==Staff
  end

  def new?
    user.class==Staff
  end

  def update?
    user.class==Staff || user.client==record
  end

  def edit?
    update?
  end

  def destroy?
    user.class==Staff
  end

  def edit_hotbutton?
    user.class==Staff || user.client==record
  end

  def update_hotbutton?
    user.class==Staff || user.client==record
  end
end