# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  answer_id    :integer
#  commenter_id :integer
#
class Comment < ApplicationRecord


  belongs_to(:commenter, { :required => false, :class_name => "User", :foreign_key => "commenter_id" })

  belongs_to(:answer, { :required => false, :class_name => "Answer", :foreign_key => "answer_id", :counter_cache => true })


end
