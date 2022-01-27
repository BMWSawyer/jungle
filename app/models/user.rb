class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }, confirmation: true
  validates :password_confirmation, presence: true
  before_save :downcase_fields

  def self.authenticate_with_credentials(email, password)
    fixed_email = email.downcase.strip
    
    @user = User.find_by_email(fixed_email)

    if @user.authenticate(password)
      @user
    else
      nil
    end
  end

  def downcase_fields
    self.email.downcase!
  end
end
