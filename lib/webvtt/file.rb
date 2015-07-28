# -*- encoding : utf-8 -*-
module Webvtt
  class File

    attr_accessor :file, :cues

    def initialize(input_file)
      if input_file.is_a?(String)
        input_file = input_file.encode('UTF-8')
        if ::File.exist?(input_file)
          @file = ::File.read(input_file)
        else
          @file = input_file
        end
      elsif input_file.is_a?(::File)
        @file = input_file.read
      else
        raise
      end
      @cues = []
      parse
    end

    def parse
      remove_bom
      if !webvtt_line?(file.lines.first)
        raise Webvtt::MalformedError
      end
      collected_lines = []
      file_lines = file.dup.lines.to_a

      file_lines.each_with_index do |line,index|
        line.chomp!

        next if webvtt_line?(line)
        if line.empty?
          if !collected_lines.empty? and !notes?(collected_lines)
            add_a_cue(collected_lines)
          end
          collected_lines = []
        elsif !line.empty? and file_lines.length == (index + 1)
          collected_lines << line
          add_a_cue(collected_lines)
        else
          collected_lines << line
        end
      end
    end

    def webvtt_line?(line)
      line[0,6] == 'WEBVTT'
    end

    def remove_bom
      file.gsub!("\uFEFF", '')
    end

private

    def add_a_cue(collected_lines)
      cue_opts = {}
      if collected_lines.first.include?('-->')
        cue_opts[:identifier] = nil
        cue_opts[:cue_line] = collected_lines.shift
      elsif collected_lines[1].include?('-->')
        cue_opts[:identifier] = collected_lines.shift
        cue_opts[:cue_line] = collected_lines.shift
      end
      cue_opts[:text] = collected_lines.join(' ')
      cues << Cue.new(cue_opts)
    end

    def notes?(collected_lines)
      if collected_lines.first.match(/^NOTE/)
        true
      else
        false
      end
    end

  end
end
