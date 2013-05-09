require 'test/unit'
require_relative '../lib/shatter'

using Shatter

class ShatterTest < Test::Unit::TestCase
	def test_basic
		actual = {:one=>1,:two=>2,:three=>3}.shatter do
			one + two + three
		end
		assert_equal expected, actual
  end 
  def test_conflict
  	override = "world"
		actual = {:message=>"world", :override=>"wrong"}.shatter do
      "#{override} #{message}"
		end
		assert_equal "hello world", actual
  end
end
=begin
class ShatterTest < Test::Unit::TestCase
  def test_basic
    assert(TestBase.new.basic(:one=>1,:two=>2,:three=>3)==6)
  end 
  def test_method_conflict
    assert(TestBase.new.conflict(:message=>"world", :override=>"wrong")=="hello world")
  end
end

class TestBase
  def basic parameters={}
    shatter(parameters) do
      one + two + three
    end
  end
  def conflict parameters={}
    shatter(parameters) do
      "#{override} #{message}"
    end
  end
  def override
    "hello"
  end
end
=end