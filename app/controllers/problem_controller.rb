# frozen_string_literal: true

# problem controller
class ProblemController < ApplicationController
  before_action :authenticate_user!, except: :all

  def new
    @notice = params[:notice]
  end

  def post
    new_problem = Problem.new
    new_problem.author = current_user.id
    new_problem.text = params[:text]
    new_problem.answer = params[:answer]
    new_problem.title = params[:title]
    if new_problem.save
      redirect_to action: 'problems', controller: 'user'
    else
      redirect_to problem_new_path
    end
  end

  def delete
    @id = params[:problem_id].to_i
    record = Problem.find(@id)
    @confirm_delete = (record.author == current_user.id.to_s)
    if @confirm_delete
      Problem.delete(record)
      respond_to { |format| format.js }
    end
  end

  def save
    @edit_problem = Problem.find(params[:problem_id].to_i)
    @confirm_edit = (@edit_problem.author.to_i == current_user.id)
    if @confirm_edit
      @edit_problem.text = params[:text]
      @edit_problem.answer = params[:answer]
      @edit_problem.title = params[:title]
      if @edit_problem.save
        redirect_to action: 'problems', controller: 'user'
      else
        notice = @edit_problem.errors.messages.map { |_k, v| v[0] }.join("\n")
        redirect_to action: 'edit', controller: 'problem', problem_id: @edit_problem.id, notice: notice
      end
    end
  end

  def edit
    @edit_problem = Problem.find(params[:problem_id])
    @text = @edit_problem.text
    @answer = @edit_problem.answer
    @title = @edit_problem.title
    @notice = params[:notice]
  end

  def all
    @search_text = params[:text]
    id = current_user.nil? ? '' : current_user.id.to_s
    if @search_text.nil?
      @list = Problem.all.reject { |problem| problem.author == id } if @list.nil?
    else
      @list = Problem.all.reject { |problem| problem.author == id }
      @list.select! do |problem|
        problem.title.include?(@search_text) or problem.text.include?(@search_text)
      end
    end
    @solved_problems = SolvedProblem.where(user_id: id.to_i).to_a.map(&:problem_id)
  end

  def check_answer
    @id = params[:problem_id].to_i
    answer = params[:answer].to_s
    @correct_answer = (Problem.find(@id).answer.to_i.round.to_s == answer)
    if @correct_answer
      solved = SolvedProblem.new
      solved.problem_id = @id
      solved.user_id = current_user.id
      solved.save
    end
    @score = User.score(current_user.id)
    respond_to { |format| format.js }
  end
end
