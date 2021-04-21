require 'test_helper'

class WebvttFileTest < Test::Unit::TestCase

  setup do
    path = File.expand_path(File.dirname(__FILE__))
    @file_path = File.join(path, 'examples', 'tolson.vtt')
    @vtt = Webvtt::File.new(@file_path)
  end

  test "should have a File class" do
    assert Webvtt::File
  end

  test "should create a new File with file path" do
    assert Webvtt::File.new(@file_path)
  end

  test "should create a new File with a File object" do
    file = File.open(@file_path)
    assert Webvtt::File.new(file)
  end

  test "should create a new File with a String as the contents of the WEBVTT file" do
    file = "WEBVTT FILE\n\n1\n00:00:00 --> 00:00:05\nIt was a frightening time but it also was a time of great student intrigue"
    assert Webvtt::File.new(file)
  end

  test "should handle files with a BOM and different line endings" do
    file = "\uFEFFWEBVTT FILE\r\n\r\n1\r\n00:00:00 --> 00:00:05\r\nIt was a frightening time but it also was a time of great student intrigue"
    assert Webvtt::File.new(file)
  end

  test "should have a file method" do
    assert @vtt.respond_to?(:file)
  end

  test "should have a file method with the contents of the original file" do
    assert @vtt.file.include?('WEBVTT')
  end

  test "should have a list of cues" do
    assert @vtt.respond_to?(:cues)
    assert @vtt.cues.is_a?(Array)
  end

  test "should have 2 cues" do
    assert_equal 2, @vtt.cues.length
  end

  test "first cue should be correct" do
    first_cue = @vtt.cues.first
    assert_equal "1", first_cue.identifier
    assert_equal "00:00:00.000", first_cue.start
    assert_equal "00:00:03.000", first_cue.end
    assert_equal "D:vertical A:start", first_cue.settings
    assert_equal "I grew up in Eastern North Carolina, <b>Edgecombe</b> County", first_cue.text
  end

  test "multiline cue text should be correct" do
    assert_equal "on a tobacco and dairy farm outside of\nTarboro.", @vtt.cues.last.text
  end

end
