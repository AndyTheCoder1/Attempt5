# == Schema Information
#
# Table name: decoratations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  answer_id  :integer
#  user_id    :integer
#
class Decoratation < ApplicationRecord


  belongs_to(:decorated_user, { :required => false, :class_name => "User", :foreign_key => "user_id" })

  belongs_to(:answer, { :required => false, :class_name => "Answer", :foreign_key => "answer_id", :counter_cache => true })


end
