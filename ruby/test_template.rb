#!/usr/local/ruby
#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---
require 'test/unit'   #(1)
require 'churn.v1'           #(2)

class  Churn_Test < Test::Unit::TestCase #(3)

  def test_month_before_is_28_days  #(4)
    assert_equal(Time.local(2005,1,1), month_before(Time.local(2005,1,29)))  #(5)
  end
  
  def test_puts_header
    assert_equal("Changes since 2005-08-05:", header(month_before(Time.local(2005,9,02))))  #(5)
  end

end
