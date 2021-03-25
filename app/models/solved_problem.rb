# frozen_string_literal: true

class SolvedProblem < ApplicationRecord
  validates_uniqueness_of :user_id, scope: [:problem_id]

  # noinspection RubyArgumentParentheses
  def self.rating
    find_by_sql("SELECT users.name as name, count(s.problem_id) as score
            from solved_problems s
            JOIN users on users.id=s.user_id
            GROUP BY s.user_id
            ORDER BY score DESC")
  end

end
