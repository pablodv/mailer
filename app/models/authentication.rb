class Authentication < ActiveRecord::Base
  # == Associations
  #
  belongs_to :user

  # == Validations
  #
  validates :provider, :uid, presence: true

  # == Class Methods
  #
  def self.find_with_omniauth(auth)
    where(provider: auth['provider'], uid: auth['uid']).first
  end

  def self.create_with_omniauth(auth)
    create(uid: auth['uid'], provider: auth['provider'])
  end
end
