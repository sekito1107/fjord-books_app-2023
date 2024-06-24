# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'nameが登録されていない場合、emailを取得する' do
    user = users(:alice)
    user.name = ''

    assert_equal 'alice@example.com', user.name_or_email
  end

  test 'nameが登録されている場合、nameを取得する' do
    user = users(:alice)

    assert_equal 'alice', user.name_or_email
  end
end
