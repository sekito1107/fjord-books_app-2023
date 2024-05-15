# frozen_string_literal: true

class ReportMention < ApplicationRecord
  belongs_to :source_report, class_name: 'Report', inverse_of: :active_mentions
  belongs_to :target_report, class_name: 'Report', inverse_of: :passive_mentions
  validates :source_report, uniqueness: { scope: :target_report }
end
