class Contact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # == Accessors
  attr_accessor :email, :subject, :body

  # == Valdiations
  validates :email, :subject, :body, presence: true
  validate :check_emails

  # == Initializer
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  # == Class methods
  def self.import(email, token)
    if email && token
      url = URI.parse("https://www.google.com/m8/feeds/contacts/#{email}/full?access_token=#{token}&GData-Version=3.0&alt=json")

      response = Net::HTTP.get_response(url)
      JSON.parse(response.body) if response.code == "200"
    end
  end

  # == Public instance methods
  def persisted?
    false
  end

  def send(user)
    Notifier.message(user, email, body, subject).deliver
  end

  protected

  def check_emails
    invalid_emails = []

    email.gsub(" ", "").split(",").each do |e|
      invalid_emails << e unless e.match(Devise::email_regexp)
    end

    unless invalid_emails.empty?
      self.errors.add(:email, :invalid)
      self.errors[:email][0] = "#{self.errors[:email].first}: #{invalid_emails.join(", ")}"
    end
  end
end
