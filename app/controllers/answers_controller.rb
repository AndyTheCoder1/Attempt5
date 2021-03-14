class AnswersController < ApplicationController
  
    def add

    the_id = params.fetch("path_id")

    int_path = the_id.to_i

    question = params.fetch("question_id")

    correct_answer = Answer.where({ :id => the_id }).at(0)

    correct_answer.decoratations_count = correct_answer.decoratations_count + 1

    correct_answer.save

    new_dec = Decoratation.new
    new_dec.user_id = @current_user.id
    new_dec.answer_id = int_path
    new_dec.save

    redirect_to("/answers/#{question}", { :notice => "Decoratation created successfully." })
    

  end

     def add_p

    the_id = params.fetch("path_id")

    int_path = the_id.to_i

    question = params.fetch("question_id")

    user_the_id = params.fetch("owner_id")

    correct_answer = Answer.where({ :id => the_id }).at(0)

    correct_answer.decoratations_count = correct_answer.decoratations_count + 1

    correct_answer.save

    new_dec = Decoratation.new
    new_dec.user_id = @current_user.id
    new_dec.answer_id = int_path
    new_dec.save

    redirect_to("/user/#{user_the_id}", { :notice => "Decoratation created successfully." })
    

  end

  def yesterday
    the_id = params.fetch("path_id")

    count = params.fetch("count")

    @count = count.to_i + 1

    @instance = Date.today

    @question = Question.where({ :id => the_id}).at(0)

    matching_answers = Answer.all

    @list_of_answers = matching_answers.order({ :created_at => :desc })

    @today = Date.today


    render({ :template => "answers/indexyesterday.html.erb" })
  end


  def tomorrow
    the_id = params.fetch("path_id")

    count = params.fetch("count")

    @count = count.to_i - 1

    @instance = Date.today

    update = the_id.to_i+2

    @question = Question.where({ :id => update}).at(0)

    matching_answers = Answer.all

    @list_of_answers = matching_answers.order({ :created_at => :desc })

    @today = Date.today


    render({ :template => "answers/indexyesterday.html.erb" })
  end


  def matching_index

    the_id = params.fetch("path_id")

    @question = Question.where({ :id => the_id}).at(0)

    matching_answers = Answer.all

    @list_of_answers = matching_answers.order({ :created_at => :desc })

    render({ :template => "answers/index.html.erb" })
  end
  
  def index
    today = Date.today

    @instance = Date.today

    test = today.day

    question_number = test+17

    #the_id = rand(9..13)

    @question = Question.where({ :id => question_number}).at(0)

    matching_answers = Answer.all

    @list_of_answers = matching_answers.order({ :created_at => :desc })

    render({ :template => "answers/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_answers = Answer.where({ :id => the_id })

    @the_answer = matching_answers.at(0)

    render({ :template => "answers/show.html.erb" })
  end

  def create
    the_answer = Answer.new
    the_answer.entry = params.fetch("query_entry")
    the_answer.owner_id = session.fetch(:user_id)
    #the_answer.image = params.fetch("query_image")
    the_answer.question_id = params.fetch("question_id")
    the_answer.decoratations_count = 0
    #the_answer.comments_count = params.fetch("query_comments_count")

    if the_answer.valid?
      the_answer.save
      redirect_to("/answers", { :notice => "Answer created successfully." })
    else
      redirect_to("/answers", { :notice => "Answer failed to create successfully." })
    end
  end



  def update
    the_id = params.fetch("path_id")
    the_answer = Answer.where({ :id => the_id }).at(0)

    the_answer.entry = params.fetch("query_entry")
    the_answer.owner_id = params.fetch("query_owner_id")
    the_answer.image = params.fetch("query_image")
    the_answer.question_id = params.fetch("query_question_id")
    the_answer.decoratations_count = params.fetch("query_decoratations_count")
    the_answer.comments_count = params.fetch("query_comments_count")

    if the_answer.valid?
      the_answer.save
      redirect_to("/answers/#{the_answer.id}", { :notice => "Answer updated successfully."} )
    else
      redirect_to("/answers/#{the_answer.id}", { :alert => "Answer failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_answer = Answer.where({ :id => the_id }).at(0)

    the_answer.destroy

    redirect_to("/answers", { :notice => "Answer deleted successfully."} )
  end
end
