# == Schema Information
#
# Table name: answers
#
#  id                  :integer          not null, primary key
#  comments_count      :integer
#  decoratations_count :integer
#  entry               :text
#  image               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  owner_id            :integer
#  question_id         :integer
#
class Answer < ApplicationRecord


  belongs_to(:owner, { :required => false, :class_name => "User", :foreign_key => "owner_id" })

  has_many(:decoratations, { :class_name => "Decoratation", :foreign_key => "answer_id", :dependent => :destroy })

  has_many(:comments, { :class_name => "Comment", :foreign_key => "answer_id", :dependent => :destroy })

  belongs_to(:question, { :required => false, :class_name => "Question", :foreign_key => "question_id", :counter_cache => true })


end
