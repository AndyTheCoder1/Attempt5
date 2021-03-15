class QuestionsController < ApplicationController
  def alltopics

    render({ :template => "questions/topics.html.erb" })
  end


  def comingsoon

    render({ :template => "questions/comingsoon.html.erb" })
  end
  
  
  
  def index
    matching_questions = Question.all

    @list_of_questions = matching_questions.order({ :created_at => :desc })

    render({ :template => "questions/index.html.erb" })
  end

  def suggest

    user = session.fetch(:user_id)

    correct_user = User.where({ :id => user }).at(0)
    
    correct_user.admin = true

    correct_user.save
      
    redirect_to("/edit_user_profile", { :notice => "You are now and admin and can add questions" })

  end

  def show
    the_id = params.fetch("path_id")

    matching_questions = Question.where({ :id => the_id })

    @the_question = matching_questions.at(0)

    render({ :template => "questions/show.html.erb" })
  end

  def create
    the_question = Question.new
    the_question.question = params.fetch("query_question")

    if the_question.valid?
      the_question.save
      redirect_to("/edit_user_profile", { :notice => "Question created successfully." })
    else
      redirect_to("/edit_user_profile", { :notice => "Question failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_question = Question.where({ :id => the_id }).at(0)

    the_question.question = params.fetch("query_question")
    the_question.answers_count = params.fetch("query_answers_count")

    if the_question.valid?
      the_question.save
      redirect_to("/questions/#{the_question.id}", { :notice => "Question updated successfully."} )
    else
      redirect_to("/questions/#{the_question.id}", { :alert => "Question failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_question = Question.where({ :id => the_id }).at(0)

    the_question.destroy

    redirect_to("/questions", { :notice => "Question deleted successfully."} )
  end
end
