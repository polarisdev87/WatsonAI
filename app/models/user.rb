class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :timeoutable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable, :invite_for => 2.weeks
         has_many :personalities
end
