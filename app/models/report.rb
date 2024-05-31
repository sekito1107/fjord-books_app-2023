# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_mentions, class_name: 'ReportMention', foreign_key: :source_report_id, dependent: :destroy, inverse_of: :source_report
  has_many :mentioning_reports, through: :active_mentions, source: :target_report
  has_many :passive_mentions, class_name: 'ReportMention', foreign_key: :target_report_id, dependent: :destroy, inverse_of: :target_report
  has_many :mentioned_reports, through: :passive_mentions, source: :source_report

  validates :title, presence: true
  validates :content, presence: true

  after_save :build_mentions

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def build_mentions
    active_mentions.destroy_all
    report_ids = content.scan(%r{(?<=http://localhost:3000/reports/)\d+})

    additional_target_report_ids = Report.where(id: report_ids).where.not(user:).pluck(:id).map(&:to_s)

    additional_target_report_ids.uniq.each do |report_id|
      active_mentions.create!(target_report_id: report_id.to_i)
    end
  end
end
