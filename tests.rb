require 'test/unit'
require './eztv'

class EztvTests < Test::Unit::TestCase

  def test_argv_check
    ez = Eztv.new
    assert_equal ez.argv_check, ''
  end

  def test_set_node
    ez = Eztv.new
    exp = ez.set_node(0)
    assert_kind_of(Nokogiri::XML::NodeSet, exp)    
  end

  def test_set_node2
    ez = Eztv.new
    assert_kind_of(OpenURI::HTTPError, ez.set_node('p'))    
  end

end
