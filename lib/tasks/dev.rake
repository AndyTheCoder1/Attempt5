desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do
require 'faker'
  25.times do
  user = User.new 
  user.username = Faker::Name.first_name
  user.password_digest = "password"
  user.save
  end
end



#  id                         :integer          not null, primary key
#  admin                      :boolean
#  email                      :string
#  follow_requests_sent_count :integer
#  password_digest            :string
#  username                   :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#