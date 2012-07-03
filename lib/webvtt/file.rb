module Webvtt
  class File

    attr_accessor :file, :cues

    def initialize(input_file)
      if input_file.is_a?(String)
        @file = ::File.read(input_file)
      elsif input_file.is_a?(::File)
        @file = input_file.read
      else
        raise
      end
      @cues = []
      parse
    end

    def parse
      if !webvtt_line?(file.first)
        raise Webvtt::MalformedError
      end
      collected_lines = []
      file_lines = file.dup.lines.to_a

      file_lines.each_with_index do |line,index|
        line.chomp!
        
        next if webvtt_line?(line)
        if line.empty? 
          add_a_cue(collected_lines) if !collected_lines.empty?
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

private

    def add_a_cue(collected_lines)
      cue_opts = {}
      if collected_lines.first.include?('-->')
        cue_opts[:identifier] = nil
        cue_opts[:cue_line] = collected_lines.first
      elsif collected_lines[1].include?('-->')
        cue_opts[:identifier] = collected_lines.first
        cue_opts[:cue_line] = collected_lines[1]
      end
      cue_opts[:text] = collected_lines[2..-1].join('')
      cues << Cue.new(cue_opts)
    end

  end
end