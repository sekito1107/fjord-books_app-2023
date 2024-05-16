# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar

  validate :format_avatar

  def check_avatar
    errors.add(:avatar, 'プロフィール画像はjpg,png,gifの中から選択してください') if avatar.attached? && !avatar.content_type.in?(%w[image/jpeg image/png image/gif])
  end
end
