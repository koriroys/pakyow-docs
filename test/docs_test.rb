require 'helper'

class DocsTest < MiniTest::Unit::TestCase
  def setup
  end

  def teardown
  end

  def test_all_docs_returned
    assert_equal 16, Docs.all.length
  end

  def test_a_category_is_returned
    assert_equal 1, Docs.find('first_category').length
    assert_equal 0, Docs.find('another_category').length
    assert_equal 0, Docs.find('').length
  end

  def test_a_topic_is_returned_for_a_category
    assert_equal 1, Docs.find('first_category', 'first_topic').length
    assert_equal 0, Docs.find('first_category', 'another_topic').length
    assert_equal 0, Docs.find('another_category', 'first_topic').length
    assert_equal 0, Docs.find('first_category', '').length
    assert_equal 0, Docs.find('', 'first_topic').length
    assert_equal 0, Docs.find('', '').length
  end
end
