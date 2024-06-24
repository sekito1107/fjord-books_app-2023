# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'アカウント新規登録,編集' do
    visit root_path

    click_on 'アカウント登録'
    fill_in 'Eメール', with: 'hoge@example.com'
    fill_in '氏名', with: 'sekito'
    fill_in '郵便番号', with: '222-2222'
    fill_in '住所', with: '北海道札幌市南区西の川2条12丁目'
    fill_in '自己紹介文', with: 'hello'
    attach_file 'ユーザ画像', Rails.root.join('test/fixtures/files/sekito.jpg')
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_on 'アカウント登録'

    assert_text 'sekito としてログイン中'
    assert_text 'アカウント登録が完了しました'

    click_on 'アカウント編集'

    fill_in 'Eメール', with: 'foo@example.com'
    fill_in '氏名', with: 'super sekito'
    fill_in '郵便番号', with: '333-3333'
    fill_in '住所', with: '北海道札幌市北区銀座横丁3条1丁目'
    fill_in '自己紹介文', with: 'done'
    attach_file 'ユーザ画像', Rails.root.join('test/fixtures/files/sekito2.jpg')
    fill_in 'パスワード', with: 'password!'
    fill_in 'パスワード（確認用）', with: 'password!'
    fill_in '現在のパスワード', with: 'password'
    click_on '更新'

    assert_text 'アカウント情報を変更しました'
    assert_text 'foo@example.com'
    assert_text 'super sekito'
    assert_text '333-3333'
    assert_text '北海道札幌市北区銀座横丁3条1丁目'
    assert_text 'done'
    assert find('img')['src'].end_with?('sekito2.jpg')
  end

  test 'アカウント削除' do
    sign_in
    visit root_path
    click_on 'アカウント編集'
    accept_confirm do
      click_button 'アカウント削除'
    end
    assert_text 'アカウントを削除しました。またのご利用をお待ちしております。'
  end

  test '自分以外のユーザーは編集出来ない' do
    sign_in
    bob = users(:bob)
    visit user_path(bob)

    assert_no_text 'このユーザーを編集'
  end

  test '再ログイン' do
    sign_in
    visit root_path
    click_on 'ログアウト'

    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'

    assert_text 'ログインしました'
  end
end
