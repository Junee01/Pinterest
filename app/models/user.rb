class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #각각의 User는 여러 pins과 comments를 가질 수 있습니다.
  has_many :pins
  has_many :comments
end
