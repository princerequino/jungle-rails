class User < ActiveRecord::Base
  has_secure_password
  validates_uniqueness_of :email
  validates_length_of :password, :minimum => 3

  scope :ci_find, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase).first }

  def authenticate_with_credentials(password, email)

    user = User.ci_find('email', email.strip.downcase)

    if user[:password_digest] == password
      return user
    end

    return nil

  end
end
