require 'test_helper'

class WebvttCueTest < Test::Unit::TestCase
  test "should have a Cue class" do
    assert Webvtt::Cue
  end

  test "should respond to identifier, start, end, settings, and text" do
    cue = Webvtt::Cue.new
    assert cue.respond_to?(:identifier)
    assert cue.respond_to?(:start)
    assert cue.respond_to?(:end)
    assert cue.respond_to?(:settings)
    assert cue.respond_to?(:text)
  end

  test "parses an individual cue" do
    cue = Webvtt::Cue.new(:identifier => "1", :cue_line => "00:00:00 --> 00:00:03.000 D:vertical A:start", :text => "I grew up in Eastern North Carolina, <b>Edgecombe</b> County")
    assert_equal '1', cue.identifier
    assert_equal '00:00:00', cue.start
    assert_equal '00:00:03.000', cue.end
    assert_equal 'D:vertical A:start', cue.settings
    assert_equal 'I grew up in Eastern North Carolina, <b>Edgecombe</b> County', cue.text
  end  

end