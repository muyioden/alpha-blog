require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "name should not be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "category should be unique" do
    
    @category.save
    @category2 = Category.new(name: "sports")
    assert_not @category2.valid?, "Category names should be unique"

  end

  test "category name should not be long" do
    @category.name = "a" * 26
    assert_not @category.valid?, "name should be shorter than 25 char"
  end

  test "categoy name should not short" do
    @category.name = "aa" 
    assert_not @category.valid?, "name should be longer that 3 char"
  end

end
