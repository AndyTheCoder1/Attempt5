# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  answers_count :integer
#  question      :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Question < ApplicationRecord
  has_many(:answers, { :class_name => "Answer", :foreign_key => "question_id", :dependent => :destroy })
end
