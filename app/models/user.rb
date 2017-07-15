class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles

  def cached_roles
    Rails.cache.fetch "user.#{self.id}.roles" do
      roles.pluck(:name)
    end
  end

  def clear_cached_roles
    Rails.cache.delete "user.#{self.id}.roles"
  end
end
