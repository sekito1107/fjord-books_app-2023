# frozen_string_literal: true

class ReportMention < ApplicationRecord
  belongs_to :source_report, class_name: 'Report'
  belongs_to :target_report, class_name: 'Report'
  validates :source_report, uniqueness: { scope: :target_report }
end
