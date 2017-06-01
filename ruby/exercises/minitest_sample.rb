class String
  def titleize
    self.split(' ').map!(&:capitalize).join(' ')
  end
end

require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! [
  Minitest::Reporters::SpecReporter.new
]

class TestTitleize < Minitest::Test
  def test_a_normal_sentence
    assert_equal "This Is A Test", "this is a test".titleize
  end

  def test_a_sentence_with_numbers
    assert_equal "Another Test 1234", "another test 1234".titleize
  end

  def test_a_sentence_with_contractions
    assert_equal "We're Don't Blah Blah", "we're don't blah blah".titleize
  end

  def test_should_fail
    flunk
  end
end
