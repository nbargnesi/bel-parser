# begin: ragel
=begin
%%{
  machine bel;

  include 'identifier.rl';
  include 'string.rl';

  action list_start {
    #$stderr.puts 'list_start'
    @opened = true
    @buffers[:list] = list()
  }

  action list_finish {
    #$stderr.puts 'list_finish'
    @closed = true
  }

  action list_end {
    $stderr.puts "list_end"
    completed = @opened && @closed
    unless completed
      @buffers[:list] = list(complete: false)
    else
      @buffers[:list].complete = completed
    end
  }

  action list_yield {
    #$stderr.puts "list_yield"
    yield @buffers[:list]
  }

  action clear {
    #$stderr.puts "clear"
    @buffers.delete(:string)
    @buffers.delete(:ident)
  }

  action string {
    #$stderr.puts "string"
    @buffers[:list_arg] = list_item(@buffers[:string])
  }

  action ident {
    #$stderr.puts "ident"
    @buffers[:list_arg] = list_item(@buffers[:ident])
  }

  action start_list {
    #$stderr.puts "start_list"
    @buffers[:list] = list()
  }

  action append_list {
    #$stderr.puts "append_list"
    # Append list argument if its value is not empty.
    list_arg_value = @buffers[:list_arg].children[0].children[0]
    if list_arg_value != ''
      @buffers[:list] <<= @buffers[:list_arg]
    end
  }

  action finish_list {
    #$stderr.puts "finish_list"
    #TODO: Mark @buffers[:list] as complete.
  }

  action error_list_string {
    #$stderr.puts "error_list_string"
    #TODO: Mark @buffers[:list_arg] string as error.
    @buffers[:list_arg] = list_item(@buffers[:string])
  }

  action error_list_ident {
    #$stderr.puts "error_list_ident"
    #TODO: Mark @buffers[:list_arg] identifier as error.
    @buffers[:list_arg] = list_item(@buffers[:ident])
  }

  action yield_complete_list {
    #$stderr.puts "yield_complete_list"
    #TODO: Mark @buffers[:list_arg] identifier as error.
    yield @buffers[:list]
  }

  action yield_error_list {
    #$stderr.puts "yield_error_list"
    @buffers[:list] ||= list()
    yield @buffers[:list]
  }

  action start_list_arg {
    #$stderr.puts "start_list_arg"
    @incomplete[:list_arg] = []
  }

  action accum_list_arg {
    #$stderr.puts "accum_list_arg"
    @incomplete[:list_arg] << fc
  }

  action end_list_arg {
    # finished list arg
    @incomplete.delete(:list_arg)
    if @buffers.key?(:string)
      ast_node = @buffers.delete(:string)
    else
      ast_node = @buffers.delete(:ident)
    end
    @buffers[:list] <<= list_item(ast_node, complete: true)
  }

  action eof_list_arg {
    # unfinished list arg
    $stderr.puts 'eof_list_arg'
    arg = @incomplete.delete(:list_arg)
    if @incomplete.key?(:string)
      ast_node = string(utf8_string(arg), complete: false)
    else
      ast_node = identifier(utf8_string(arg), complete: false)
    end
    @buffers[:list] <<= list_item(ast_node, complete: false)
    @buffers[:list].complete = false
    yield @buffers[:list]
  }

  action err_list_arg {
    # unfinished list arg
    #$stderr.puts 'err_list_arg'
    arg = @incomplete.delete(:list_arg)
    if @incomplete.key?(:string)
      ast_node = string(utf8_string(arg), complete: false)
    else
      ast_node = identifier(utf8_string(arg), complete: false)
    end
    @buffers[:list] <<= list_item(ast_node, complete: false)
    @buffers[:list].complete = false
    yield @buffers[:list]
  }

  action err_members {
    # unfinished list arg
    $stderr.puts 'err_members'
    arg = @incomplete.delete(:list_arg) || []
    if @incomplete.key?(:string)
      ast_node = string(utf8_string(arg), complete: false)
    else
      ast_node = identifier(utf8_string(arg), complete: false)
    end
    @buffers[:list] <<= list_item(ast_node, complete: false)
    @buffers[:list].complete = false
    yield @buffers[:list]
  }

  action eof_members {
    $stderr.puts 'eof_members'
    # unfinished members
    #$stderr.puts "incomplete members"
    #$stderr.puts @buffers[:string]
  }

  action err_list {
    $stderr.puts "err_list"
  }

  action eof_list {
    $stderr.puts 'eof_list'
    unless @closed
      $stderr.puts "incomplete list - why?"
    else
      #$stderr.puts "complete list"
    end
  }

  start_list = '{' SP* %list_start;
  end_list = SP* '}' %list_finish;

  ident_list_member = id_ident
                      <to(accum_list_arg)
                      $err(err_list_arg)
                      ;
  string_list_member = str_string
                      <to(accum_list_arg)
                      $err(err_list_arg)
                      ;
  list_member = (string_list_member | ident_list_member)
                >start_list_arg
                %end_list_arg
                $err(err_list_arg)
                $eof(eof_list_arg)
                ;
  members = (list_member (COMMA_DELIM list_member)*)
            $eof(eof_members)
            $err(err_members)
            ;

  lst_list =
    start_list
    members
    end_list
    %list_end
    $eof(eof_list)
    $err(err_list)
    ;

  list_ast_new := (start_list members end_list |
                  start_list end_list |
                  start_list |
                  start_list?)
                  NL?
                  $list_end
                  $list_yield
                  $eof(eof_list)
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
      module List

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
            @opened     = false
            @closed     = false
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
    BELParser::Parsers::Common::List.parse(line) { |obj|
      puts obj.inspect
    }
  end
end

# vim: ft=ruby ts=2 sw=2:
# encoding: utf-8
