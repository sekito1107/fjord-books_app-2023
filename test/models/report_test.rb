# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    alice = users(:alice)
    bob = users(:bob)
    report = reports(:alice)

    assert report.editable?(alice)
    assert_not report.editable?(bob)
  end

  test 'created_on' do
    report = reports(:alice)
    assert_equal Date.current, report.created_on
  end

  test 'save_mentions' do
    alice_report = reports(:alice)
    bob = users(:bob)

    bob_report = bob.reports.create!(
      title: '言及テスト',
      content: "http://localhost:3000/reports/#{alice_report.id}"
    )

    assert_equal [bob_report], alice_report.mentioned_reports
    assert_equal [alice_report], bob_report.mentioning_reports
  end
end
