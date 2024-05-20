# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    sign_in
  end

  def set_book
    @book = books(:dragon_ball)
  end

  test '本の一覧を表示する' do
    visit books_url
    assert_text '本の一覧'
    assert_text 'ドラゴンボール'
    assert_text '嘘喰い'
    assert_text '東京アンダーグラウンド'
  end

  test '本の新規登録' do
    visit books_url
    click_on '本の新規作成'

    fill_in 'タイトル', with: 'ダーウィンズゲーム'
    fill_in 'メモ', with: '予測不能の極限異能力バトル'
    fill_in '著者', with: 'FLIPFLOPs'
    attach_file '画像', Rails.root.join('test/fixtures/files/darwins_game.jpg')
    click_on '登録する'

    assert_text '本が作成されました'
    assert_text 'ダーウィンズゲーム'
    assert_text '予測不能の極限異能力バトル'
    assert find('img')['src'].end_with?('darwins_game.jpg')
  end

  test '本にコメント' do
    set_book
    visit book_url(@book)
    fill_in 'comment[content]', with: '世界的に有名な漫画ですね'
    click_on 'コメントする'

    assert_text 'コメントが作成されました'
    assert_text '世界的に有名な漫画ですね'
  end

  test '本の編集' do
    set_book
    visit book_url(@book)
    click_on 'この本を編集'

    fill_in 'タイトル', with: 'スラムダンク'
    fill_in 'メモ', with: 'スポーツ漫画屈指の傑作'
    fill_in '著者', with: '井上雄彦'
    click_on '更新する'

    assert_text '本が更新されました'
    assert_text 'スラムダンク'
    assert_text 'スポーツ漫画屈指の傑作'
    assert_text '井上雄彦'
  end

  test '本の削除' do
    set_book
    visit book_url(@book)
    click_on 'この本を削除'
    assert_text '本が削除されました。'
  end
end
