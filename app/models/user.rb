class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.score(id)
    score = SolvedProblem.find_by_sql(" SELECT count(problem_id) as value
             from solved_problems
             group by user_id
             having user_id=#{id}")[0]
    score.nil? ? 0 : score.value
  end

end
