# begin: ragel
=begin
%%{
  machine bel;

  include 'common.rl';

  action start_identifier {
    @incomplete[:ident] = []
  }

  action accum_identifier {
    @incomplete[:ident] << fc
  }

  action end_identifier {
    ident = @incomplete.delete(:ident) || []
    completed = !ident.empty?
    ast_node = identifier(utf8_string(ident), complete: completed)
    @buffers[:ident] = ast_node
  }

  action yield_identifier {
    yield @buffers[:ident]
  }

  ID_CHARS = [a-zA-Z0-9_]+;
  ident =
    ID_CHARS
    >start_identifier
    $accum_identifier
    %end_identifier
    ;

  maybe_ident =
    ident?
    ;

  an_ident =
    ident
    ;

  ident_node :=
    ident
    NL?
    %yield_identifier
    ;
}%%
=end
# end: ragel

require_relative '../ast/node'
require_relative '../mixin/buffer'
require_relative '../nonblocking_io_wrapper'

module BELParser
  module Parsers
    module Common
      module Identifier

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
            @buffers    = {}
            @incomplete = {}
            data        = @content.unpack('C*')
            p           = 0
            pe          = data.length
            eof         = data.length

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
    BELParser::Parsers::Common::Identifier.parse(line) { |obj|
      puts obj.inspect
    }
  end
end

# vim: ft=ruby ts=2 sw=2:
# encoding: utf-8
