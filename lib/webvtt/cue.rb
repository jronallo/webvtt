module Webvtt
  class Cue
    attr_accessor :identifier, :start, :end, :settings, :text
    def initialize(opts={})
      if !opts.empty?
        @identifier = opts[:identifier]
        @text       = opts[:text]
        cue_parts = opts[:cue_line].split('-->')
        @start = cue_parts.first.strip
        remaining_cue_parts = cue_parts.last.split(" ")
        @end = remaining_cue_parts.shift.strip
        @settings = remaining_cue_parts.join(' ')
      end

    end
  end
end