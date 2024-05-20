# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include ActionView::Helpers::TranslationHelper

  setup do
    sign_in
  end

  test '日報の一覧を表示する' do
    visit reports_url
    assert_text '日報の一覧'
    assert_text 'aliceです'
    assert_text 'こんにちは'
  end

  test '日報の新規作成' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: '環境が与える学習効率'
    fill_in '内容', with: '今日はいい風が入ってきたので、集中できました。'
    click_on '登録する'

    assert_text '日報が作成されました'
    assert_text '環境が与える学習効率'
    assert_text '今日はいい風が入ってきたので、集中できました。'
    assert_text 'alice'
    assert_text l(Date.current)
  end

  test '不足項目があると日報が作成できない' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: ''
    fill_in '内容', with: '今日はいい風が入ってきたので、集中できました。'
    click_on '登録する'

    assert_text '1件のエラーがあるため、この日報は保存できませんでした'
    assert_text 'タイトルを入力してください'

    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: '環境が与える学習効率'
    fill_in '内容', with: ''
    click_on '登録する'

    assert_text '1件のエラーがあるため、この日報は保存できませんでした'
    assert_text '内容を入力してください'
  end

  test '日報にコメント' do
    report = reports(:alice)
    visit report_url(report)
    fill_in 'comment[content]', with: '素晴らしい日報ですね'
    click_on 'コメントする'

    assert_text 'コメントが作成されました'
    assert_text '素晴らしい日報ですね'
  end

  test '日報の編集' do
    report = reports(:alice)
    visit report_url(report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: 'aliceです'
    fill_in '内容', with: '皆さん、こんにちは。'
    click_on '更新する'

    assert_text '日報が更新されました'
    assert_text '皆さん、こんにちは。'
    assert_text 'alice'
    assert_text l(report.created_on)
  end

  test '自身以外の日報は編集も削除もできない' do
    report = reports(:bob)
    visit report_url(report)

    assert_no_text 'この日報を編集'
    assert_no_text 'この日報を削除'
  end

  test '日報の削除' do
    report = reports(:alice)
    visit report_url(report)
    click_on 'この日報を削除'
    assert_text '日報が削除されました。'
  end
end
