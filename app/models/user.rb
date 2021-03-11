# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  admin                      :boolean
#  email                      :string
#  follow_requests_sent_count :integer
#  password_digest            :string
#  username                   :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password



  has_many(:own_answers, { :class_name => "Answer", :foreign_key => "owner_id", :dependent => :destroy })

  has_many(:comments, { :class_name => "Comment", :foreign_key => "commenter_id", :dependent => :destroy })

  has_many(:follow_requests_sent, { :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy })

  has_many(:follow_requests_recieved, { :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy })

  has_many(:decoratations, { :class_name => "Decoratation", :foreign_key => "user_id", :dependent => :destroy })


  has_many(:recipients, { :through => :follow_requests_sent, :source => :recipient })

  has_many(:recieved_follow_requests, { :through => :follow_requests_recieved, :source => :sender })



end
