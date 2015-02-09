class ServiceRequestPolicy < ApplicationPolicy
  def show?
    !user.nil?
  end

  def submit?
    !user.nil?
  end

  def edit?
    user.is_a? Staff
  end

  def update?
    user.class==Staff
  end
end