class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def current_user?(user)
    current_user.id == user.id
  end
end
