# frozen_string_literal: true

class Problem < ApplicationRecord
  validates :title, presence: { value: true, message: 'Поле название должно быть заполенным' },
                    length: { minimum: 8, message: 'Минимальная длина названия - 8 символов' },
                    uniqueness: { value: true, message: 'Такое название уже сущесвует' }
  validates :answer, presence: { value: true, message: 'Поле ответ должно быть заполненым' },
                     numericality: true
  validates :text, presence: { value: true, message: 'Текст задачи должен быть заполнен' },
                   length: { minimum: 10, maximum: 700, message: 'Текст задачи должен сожержать от 10 до 700 символов' }
  validates :author, presence: { value: true, message: 'df' }, numericality: true

  def author_name
    User.find(author).name
  end

  def self.by_user(id)
    @list = Problem.find_by_sql("SELECT s.count as count,id, title, text, answer from problems
            left join (select problem_id, count(user_id) as count from solved_problems
            group by problem_id) s on s.problem_id = problems.id
            where problems.author = #{id.to_s}")
  end
end
