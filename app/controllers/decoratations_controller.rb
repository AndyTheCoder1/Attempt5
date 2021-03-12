class DecoratationsController < ApplicationController
  
  def add

    the_id = params.fetch("path_id")

    matching_decoratations = Answer.where({ :id => the_id })

    matching_decorations = matching_decorations + 1

    matching_decorations.save

    redirect_to("/answers", { :notice => "Decoratation created successfully." })


  end
  
  
  def index
    matching_decoratations = Decoratation.all

    @list_of_decoratations = matching_decoratations.order({ :created_at => :desc })

    render({ :template => "decoratations/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_decoratations = Decoratation.where({ :id => the_id })

    @the_decoratation = matching_decoratations.at(0)

    render({ :template => "decoratations/show.html.erb" })
  end

  def create
    the_decoratation = Decoratation.new
    the_decoratation.user_id = params.fetch("query_user_id")
    the_decoratation.answer_id = params.fetch("query_answer_id")

    if the_decoratation.valid?
      the_decoratation.save
      redirect_to("/decoratations", { :notice => "Decoratation created successfully." })
    else
      redirect_to("/decoratations", { :notice => "Decoratation failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_decoratation = Decoratation.where({ :id => the_id }).at(0)

    the_decoratation.user_id = params.fetch("query_user_id")
    the_decoratation.answer_id = params.fetch("query_answer_id")

    if the_decoratation.valid?
      the_decoratation.save
      redirect_to("/decoratations/#{the_decoratation.id}", { :notice => "Decoratation updated successfully."} )
    else
      redirect_to("/decoratations/#{the_decoratation.id}", { :alert => "Decoratation failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_decoratation = Decoratation.where({ :id => the_id }).at(0)

    the_decoratation.destroy

    redirect_to("/decoratations", { :notice => "Decoratation deleted successfully."} )
  end
end
