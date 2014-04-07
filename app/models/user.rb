class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_welcome_email
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_name,:mobile_number
  # attr_accessible :title, :body
  has_many :audits
  has_many :activities
  
  
  def gravatar_url
      
      stripped_email = email.strip
      downcased_email = stripped_email.downcase
      hash = Digest::MD5.hexdigest(downcased_email)
      
      "http://gravatar.com/avatar/#{hash}"
      
  end
  
  def create_activity(item, action)
      
      activity = activities.new
      activity.targetable = item
      
      activity.action = action
      activity.save
      activity
  
  end
  def self.weekly_update
      @user = User.all
      @user.each do |u|
        UsersMailer.weekly_mail(u).deliver
    end
  end
   private

    def send_welcome_email
      UserMailer.welcome_email(self).deliver
    end 
  end
