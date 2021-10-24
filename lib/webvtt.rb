# -*- encoding : utf-8 -*-
require "webvtt/version"

module Webvtt
  # Your code goes here...
  class MalformedError < StandardError; end
end

require 'webvtt/file'
require 'webvtt/cue'
