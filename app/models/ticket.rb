class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :author, class_name: "User"
  has_many :assets
  accepts_nested_attributes_for :assets
  validates :title, :description, presence: true
  validates :description, length: { minimum: 10}
 
  
 
  
end
