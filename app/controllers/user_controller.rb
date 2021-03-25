# frozen_string_literal: true

# user controller
class UserController < ApplicationController
  before_action :authenticate_user!, except: :rating

  def profile
    @score = User.score(current_user.id)
  end

  def self.calc_score(id)
    User.score(id)
  end

  def logout; end

  def problems
    @list = Problem.by_user(current_user.id)
  end

  def rating
    @users = SolvedProblem.rating
  end
end
