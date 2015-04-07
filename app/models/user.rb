class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :roles
  has_many :tickets 
  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
  
  def role_on(project)
    roles.find_by(project_id: project).try(:name)
  end
end
