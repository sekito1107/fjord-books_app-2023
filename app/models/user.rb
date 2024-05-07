# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar

  validate :avatar_format

  def avatar_format
    return unless avatar.attached? && !avatar.content_type.in?(%w[image/jpeg image/png image/gif])

    errors.add(:avatar, 'プロフィール画像はjpg,png,gifの中から選択してください')
  end
end
