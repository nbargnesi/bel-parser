# begin: ragel
=begin
%%{
  machine bel;

  include 'common.rl';

  action start_string {
    @buffers[:string] = []
  }

  action append_string {
    (@buffers[:string] ||= []) << fc
  }

  action finish_string {
    @buffers[:string] = string(utf8_string(@buffers[:string]))
  }

  action error_string {
    @buffers[:string] ||= []
    @buffers[:string] = string(utf8_string(@buffers[:string]).sub(/\n$/, ''))
  }

  action yield_complete_string {
    yield @buffers[:string]
  }

  action yield_error_string {
    @buffers[:string] ||= []
    yield @buffers[:string]
  }

  STRING  =
    ('"' ('\\\"' | [^"])** '"') >start_string $append_string %finish_string $err(error_string);

  string :=
    STRING $err(yield_error_string) %yield_complete_string
    NL;
}%%
=end
# end: ragel

require_relative '../ast/node'
require_relative '../mixin/buffer'
require_relative '../nonblocking_io_wrapper'

module BELParser
  module Parsers
    module Common
      module String

        class << self

          MAX_LENGTH = 1024 * 128 # 128K

          def parse(content)
            return nil unless content

            Parser.new(content).each do |obj|
              yield obj
            end
          end
        end

        private

        class Parser
          include Enumerable
          include BELParser::Parsers::Buffer
          include BELParser::Parsers::AST::Sexp

          def initialize(content)
            @content = content
      # begin: ragel        
            %% write data;
      # end: ragel        
          end

          def each
            @buffers = {}
            data     = @content.unpack('C*')
            p        = 0
            pe       = data.length
            eof      = data.length

      # begin: ragel        
            %% write init;
            %% write exec;
      # end: ragel        
          end
        end
      end
    end
  end
end

if __FILE__ == $0
  $stdin.each_line do |line|
    BELParser::Parsers::Common::String.parse(line) { |obj|
      puts obj.inspect
    }
  end
end

# vim: ft=ruby ts=2 sw=2:
# encoding: utf-8