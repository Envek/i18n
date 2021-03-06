require 'test_helper'
require 'i18n/core_ext/hash'
require 'active_support/core_ext/hash'

class I18nCoreExtHashInterpolationTest < I18n::TestCase
  using I18n::HashRefinements

  test "#deep_symbolize_keys" do
    hash = { 'foo' => { 'bar' => { 'baz' => 'bar' } } }
    expected = { :foo => { :bar => { :baz => 'bar' } } }
    assert_equal expected, hash.deep_symbolize_keys
  end

  test "#deep_symbolize_keys with numeric keys" do
    hash = { 1 => { 2 => { 3 => 'bar' } } }
    expected = { 1 => { 2 => { 3 => 'bar' } } }
    assert_equal expected, hash.deep_symbolize_keys
  end

  test "#slice" do
    hash = { :foo => 'bar',  :baz => 'bar' }
    expected = { :foo => 'bar' }
    assert_equal expected, hash.slice(:foo)
  end

  test "#slice non-existent key" do
    hash = { :foo => 'bar',  :baz => 'bar' }
    expected = { :foo => 'bar' }
    assert_equal expected, hash.slice(:foo, :not_here)
  end

  test "#except" do
    hash = { :foo => 'bar',  :baz => 'bar' }
    expected = { :foo => 'bar' }
    assert_equal expected, hash.except(:baz)
  end

  test "#deep_merge!" do
    hash = { :foo => { :bar => { :baz => 'bar' } }, :baz => 'bar' }
    hash.deep_merge!(:foo => { :bar => { :baz => 'foo' } })

    expected = { :foo => { :bar => { :baz => 'foo' } }, :baz => 'bar' }
    assert_equal expected, hash
  end

  test "#except supports ActiveSupport::HashWithIndifferentAccess" do
    hash = { :foo => 'bar',  :baz => 'bar' }.with_indifferent_access
    expected = { :foo => 'bar' }.with_indifferent_access
    assert_equal expected, hash.except(:baz)
  end
end
