# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
        if user.admin?
          can :manage, :all
        else
          #can [:read, :update, :destroy], Post
          #can :manage, User
          #can :read, :all
          #if post.user_id == user.id
          #  can [:read, :update, :destroy], Post
          #end
          if user.present?
            can :manage, Post, user_id: user.id
          end
        end
      end
  end

