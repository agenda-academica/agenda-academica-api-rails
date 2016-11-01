require 'exponent-server-sdk'

class User < ActiveRecord::Base
  has_many :universidades

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  before_validation :set_uid_as_email

  # mount_uploader :avatar, AvatarUploader

  validates :provider, :uid, :email, presence: true

  def as_json(*)
    UserSerializer.new(self, {root: false})
  end

  def set_uid_as_email
    self.uid = email if uid.blank?
  end

  def self.send_push_notification
    exponent.publish(
      exponentPushToken: 'ExponentPushToken[WgeYRaGKTOn5j3H8tPZMMh]',
      message: 'Send Push Notification Test',
      data: { foo: 'bar' },
    )
  end
end
