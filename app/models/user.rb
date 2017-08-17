class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_many :donations
  has_many :requests
  before_save :set_saldo_zero
  
  def set_saldo_zero
    self.saldo ||= 0
  end
  
  
  def send_donation (value)
  
    self.donations.create(value: value)
  end
end
