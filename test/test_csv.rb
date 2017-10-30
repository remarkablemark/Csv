require 'minitest/autorun'
require_relative '../csv.rb'

class TestCsv < MiniTest::Test
  def test_that_newline_delimites
    expected = [[]]
    actual = Csv.parse("\n")
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_that_newlines_delimite
    expected = [[], []]
    actual = Csv.parse("\n\n")
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_that_comma_separates
    expected = [[nil, nil]]
    actual = Csv.parse(',')
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_that_commas_separate
    expected = [[nil, nil, nil]]
    actual = Csv.parse(',,')
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_commas_and_newlines
    expected = [[nil, nil], [nil, nil]]
    actual = Csv.parse(",\n,\n")
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_single_field
    expected = [['a']]
    actual = Csv.parse('a')
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_multiple_fields
    expected = [['a', 'b']]
    actual = Csv.parse('a,b')
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_multiple_records
    expected = [['a', 'b', 'c'], ['d', 'e', 'f']]
    actual = Csv.parse("a,b,c\nd,e,f\n")
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_empty_quoted_field
    expected = [[""]]
    actual = Csv.parse('""')
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_empty_quoted_field_with_newline
    expected = [['']]
    actual = Csv.parse("\"\"\n")
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_quoted_field
    expected = [['a']]
    actual = Csv.parse('"a"')
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_quoted_fields
    expected = [['a', 'b']]
    actual = Csv.parse('"a","b"')
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_quoted_field_with_newline
    expected = [["wraps,\nonto another line"]]
    actual = Csv.parse('"wraps,' + "\n" + 'onto another line"')
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_quoted_and_unquoted_fields
    expected = [['"quoted"', 'foo', 'bar'], ['baz', ' more quotes ', 'qux']]
    actual = Csv.parse("\"\"\"quoted\"\"\",foo,bar\nbaz,\" more quotes \",qux")
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_nested_quoted_field
    expected = [["wraps,\nonto \"two\""]]
    actual = Csv.parse("\"wraps,\nonto \"\"two\"\"\"")
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_nested_quoted_fields
    expected = [["wraps,\nonto \"two\" lines", "another \none,"]]
    actual = Csv.parse("\"wraps,\nonto \"\"two\"\" lines\",\"another \none,\"")
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_quoted_and_unquoted_fields_with_newline
    expected = [['one', "two wraps,\nonto \"two\" lines", 'three'], ['4', nil, '6']]
    actual = Csv.parse("one,\"two wraps,\nonto \"\"two\"\" lines\",three\n4,,6")
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end

  def test_for_custom_separator_and_quote
    expected = [['alternate', '"quote"'], [], ['character', 'hint: |']]
    actual = Csv.parse("|alternate|\t|\"quote\"|\n\n|character|\t|hint: |||", "\t", '|')
    assert_equal expected.to_s, actual.to_s
    assert expected == actual
  end
end
