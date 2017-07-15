class PostPolicy < ApplicationPolicy
  def show?
    super && (author? || reader? || admin?)
  end

  def update?
    author? || admin?
  end

  def destroy?
    author? || admin?
  end

  private

    def author?
      user == record.author
    end

    def admin?
      user.cached_roles.include? 'admin'
    end

    def reader?
      user.cached_roles.include? 'reader'
    end
end