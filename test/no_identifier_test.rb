require 'test_helper'

class WebvttNoIdentifierFileTest < Test::Unit::TestCase

  setup do
    path = File.expand_path(File.dirname(__FILE__))
    @file_path = File.join(path, 'examples', 'no-identifier.vtt')
    @vtt = Webvtt::File.new(@file_path)
  end

  test "first cue with no identifier should be correct" do
    first_cue = @vtt.cues.first
    assert_equal nil, first_cue.identifier
    assert_equal "00:00:00.000", first_cue.start
    assert_equal "00:00:03.000", first_cue.end
    assert_equal "D:vertical A:start", first_cue.settings
    assert_equal "I grew up in Eastern North Carolina, <b>Edgecombe</b> County", first_cue.text
  end

  test "second cue with no identifier and no settings should be correct" do
    last_cue = @vtt.cues.last
    assert_equal nil, last_cue.identifier
    assert_equal "00:00:03.300", last_cue.start
    assert_equal "00:00:07.800", last_cue.end
    assert_equal "", last_cue.settings
    assert_equal "on a tobacco and dairy farm outside of\nTarboro.", last_cue.text
  end

end
