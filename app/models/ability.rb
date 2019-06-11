# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    class Ability
      include CanCan::Ability
      def initialize(user)
        if user.admin?
          can :manage, :all
        else
          #can [:read, :update, :destroy], Post
          #can :manage, User
          can :read, :all
        end
      end
    end
  end
end
