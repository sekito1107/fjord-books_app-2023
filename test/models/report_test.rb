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

    # 更新時に関連が維持されるかの確認
    bob_report.update(title: '言及維持テスト', content: "http://localhost:3000/reports/#{alice_report.id}")
    bob_report.reload
    alice_report.reload

    assert_equal [bob_report], alice_report.mentioned_reports
    assert_equal [alice_report], bob_report.mentioning_reports

    # 更新時に関連が削除されるかの確認
    bob_report.update(title: '言及テスト', content: '言及を無くしました')
    bob_report.reload
    alice_report.reload

    assert_equal [], alice_report.mentioned_reports
    assert_equal [], bob_report.mentioning_reports

    # 削除テスト前の準備

    bob_report.update(title: '言及テスト', content: "http://localhost:3000/reports/#{alice_report.id}")
    bob_report.reload
    alice_report.reload

    assert_equal [bob_report], alice_report.mentioned_reports
    assert_equal [alice_report], bob_report.mentioning_reports

    # 削除時に関連が正しく削除されるかのテスト

    bob_report.destroy
    alice_report.reload
    assert_equal [], alice_report.mentioned_reports

  end
end
