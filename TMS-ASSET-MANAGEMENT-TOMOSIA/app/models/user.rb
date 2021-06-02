class User < ApplicationRecord
  extend Enumerize

  has_many :requests 
  has_many :items, through: :requests
  has_many :projects
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, :phone_number, presence: true
  validates :email, format: { with:  /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true,  presence: true

  enumerize :role, in: {
    user: 0,
    manager: 1,
    admin: 2
  }, predicates: true
  
  scope :employees, -> {where role: 'user'}

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    else
      all
    end
  end

end
