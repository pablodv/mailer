class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # == Associations
  #
  has_many :authentications

  # == Validations
  #
  validates :first_name, :last_name, :username, presence: true

  # == Class methos
  #
  def self.find_or_create_with_omniauth(auth)
    user = nil

    if authentication = Authentication.find_with_omniauth(auth)
      user = authentication.user

    elsif user = User.where(email: auth.info.email).first
      user.authentications.create_with_omniauth(auth)

    else
      user = User.new_with_omniauth(auth)
      user.save(validate: false)
      user.authentications.create_with_omniauth(auth)
    end

    user
  end

  def self.new_with_omniauth(auth)
    User.new(
      first_name: auth.info.first_name || auth.info.name.split(" ")[0],
      last_name: auth.info.first_name || auth.info.name.split(" ")[1],
      username: auth.info.nickname || auth.info.email.split("@")[0],
      email: auth.info.email)
  end
end
