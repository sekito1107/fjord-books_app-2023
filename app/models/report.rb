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
    reset_active_mentions
    return unless (match_data = %r{localhost:3000/reports/(\d+)}.match(content))

    mention = ReportMention.new
    mention.source_report_id = id
    mention.target_report_id = match_data[1].to_i
    mention.save
  end

  def reset_active_mentions
    active_mentions.each(&:destroy)
  end
end
