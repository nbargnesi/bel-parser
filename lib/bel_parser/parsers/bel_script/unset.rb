
# begin: ragel
=begin

class << self
	attr_accessor :_bel_actions
	private :_bel_actions, :_bel_actions=
end
self._bel_actions = [
	0, 1, 1, 1, 4, 1, 6, 2, 
	0, 1, 2, 2, 3, 2, 4, 5, 
	3, 2, 7, 8
]

class << self
	attr_accessor :_bel_key_offsets
	private :_bel_key_offsets, :_bel_key_offsets=
end
self._bel_key_offsets = [
	0, 0, 2, 4, 6, 8, 10, 12, 
	21, 29, 36, 44, 44
]

class << self
	attr_accessor :_bel_trans_keys
	private :_bel_trans_keys, :_bel_trans_keys=
end
self._bel_trans_keys = [
	85, 117, 78, 110, 83, 115, 69, 101, 
	84, 116, 9, 32, 9, 32, 95, 48, 
	57, 65, 90, 97, 122, 10, 95, 48, 
	57, 65, 90, 97, 122, 95, 48, 57, 
	65, 90, 97, 122, 10, 95, 48, 57, 
	65, 90, 97, 122, 0
]

class << self
	attr_accessor :_bel_single_lengths
	private :_bel_single_lengths, :_bel_single_lengths=
end
self._bel_single_lengths = [
	0, 2, 2, 2, 2, 2, 2, 3, 
	2, 1, 2, 0, 0
]

class << self
	attr_accessor :_bel_range_lengths
	private :_bel_range_lengths, :_bel_range_lengths=
end
self._bel_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 3, 
	3, 3, 3, 0, 0
]

class << self
	attr_accessor :_bel_index_offsets
	private :_bel_index_offsets, :_bel_index_offsets=
end
self._bel_index_offsets = [
	0, 0, 3, 6, 9, 12, 15, 18, 
	25, 31, 36, 42, 43
]

class << self
	attr_accessor :_bel_indicies
	private :_bel_indicies, :_bel_indicies=
end
self._bel_indicies = [
	0, 0, 1, 2, 2, 1, 3, 3, 
	1, 4, 4, 1, 5, 5, 1, 6, 
	6, 1, 8, 8, 9, 9, 9, 9, 
	7, 10, 11, 11, 11, 11, 7, 13, 
	13, 13, 13, 12, 14, 15, 15, 15, 
	15, 12, 1, 1, 0
]

class << self
	attr_accessor :_bel_trans_targs
	private :_bel_trans_targs, :_bel_trans_targs=
end
self._bel_trans_targs = [
	2, 0, 3, 4, 5, 6, 7, 0, 
	7, 8, 11, 8, 0, 10, 12, 10
]

class << self
	attr_accessor :_bel_trans_actions
	private :_bel_trans_actions, :_bel_trans_actions=
end
self._bel_trans_actions = [
	0, 0, 0, 0, 0, 0, 5, 3, 
	0, 7, 16, 1, 13, 7, 10, 1
]

class << self
	attr_accessor :_bel_eof_actions
	private :_bel_eof_actions, :_bel_eof_actions=
end
self._bel_eof_actions = [
	0, 0, 0, 0, 0, 0, 0, 3, 
	3, 13, 13, 0, 0
]

class << self
	attr_accessor :bel_start
end
self.bel_start = 1;
class << self
	attr_accessor :bel_first_final
end
self.bel_first_final = 11;
class << self
	attr_accessor :bel_error
end
self.bel_error = 0;

class << self
	attr_accessor :bel_en_ident
end
self.bel_en_ident = 9;
class << self
	attr_accessor :bel_en_unset
end
self.bel_en_unset = 1;


begin
	p ||= 0
	pe ||= data.length
	cs = bel_start
end

begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _bel_key_offsets[cs]
	_trans = _bel_index_offsets[cs]
	_klen = _bel_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p].ord < _bel_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _bel_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _bel_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p].ord < _bel_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _bel_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _bel_indicies[_trans]
	cs = _bel_trans_targs[_trans]
	if _bel_trans_actions[_trans] != 0
		_acts = _bel_trans_actions[_trans]
		_nacts = _bel_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _bel_actions[_acts - 1]
when 0 then
		begin

    @buffers[:ident] = []
  		end
when 1 then
		begin

    (@buffers[:ident] ||= []) << data[p].ord
  		end
when 2 then
		begin

    @buffers[:ident] = identifier(utf8_string(@buffers[:ident]))
  		end
when 3 then
		begin

    yield @buffers[:ident]
  		end
when 4 then
		begin

    unless @buffers[:ident].is_a?(::AST::Node)
      @buffers[:ident] ||= []
      @buffers[:ident]   = identifier(utf8_string(@buffers[:ident]).sub(/\n$/, ''))
    end
  		end
when 5 then
		begin

    @buffers[:ident] ||= []
    yield @buffers[:ident]
  		end
when 6 then
		begin

    @buffers[:unset] = unset()
  		end
when 7 then
		begin

    @buffers[:unset] = @buffers[:unset] << name(@buffers[:ident])
  		end
when 8 then
		begin

    yield @buffers[:unset]
  		end
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if p == eof
	__acts = _bel_eof_actions[cs]
	__nacts =  _bel_actions[__acts]
	__acts += 1
	while __nacts > 0
		__nacts -= 1
		__acts += 1
		case _bel_actions[__acts - 1]
when 4 then
		begin

    unless @buffers[:ident].is_a?(::AST::Node)
      @buffers[:ident] ||= []
      @buffers[:ident]   = identifier(utf8_string(@buffers[:ident]).sub(/\n$/, ''))
    end
  		end
when 5 then
		begin

    @buffers[:ident] ||= []
    yield @buffers[:ident]
  		end
		end # eof action switch
	end
	if _trigger_goto
		next
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end


=end
# end: ragel

require_relative '../ast/node'
require_relative '../mixin/buffer'
require_relative '../nonblocking_io_wrapper'

module BELParser
  module Parsers
    module BELScript
      module Unset

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
            
class << self
	attr_accessor :_bel_actions
	private :_bel_actions, :_bel_actions=
end
self._bel_actions = [
	0, 1, 1, 1, 4, 1, 6, 2, 
	0, 1, 2, 2, 3, 2, 4, 5, 
	3, 2, 7, 8
]

class << self
	attr_accessor :_bel_key_offsets
	private :_bel_key_offsets, :_bel_key_offsets=
end
self._bel_key_offsets = [
	0, 0, 2, 4, 6, 8, 10, 12, 
	21, 29, 36, 44, 44
]

class << self
	attr_accessor :_bel_trans_keys
	private :_bel_trans_keys, :_bel_trans_keys=
end
self._bel_trans_keys = [
	85, 117, 78, 110, 83, 115, 69, 101, 
	84, 116, 9, 32, 9, 32, 95, 48, 
	57, 65, 90, 97, 122, 10, 95, 48, 
	57, 65, 90, 97, 122, 95, 48, 57, 
	65, 90, 97, 122, 10, 95, 48, 57, 
	65, 90, 97, 122, 0
]

class << self
	attr_accessor :_bel_single_lengths
	private :_bel_single_lengths, :_bel_single_lengths=
end
self._bel_single_lengths = [
	0, 2, 2, 2, 2, 2, 2, 3, 
	2, 1, 2, 0, 0
]

class << self
	attr_accessor :_bel_range_lengths
	private :_bel_range_lengths, :_bel_range_lengths=
end
self._bel_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 3, 
	3, 3, 3, 0, 0
]

class << self
	attr_accessor :_bel_index_offsets
	private :_bel_index_offsets, :_bel_index_offsets=
end
self._bel_index_offsets = [
	0, 0, 3, 6, 9, 12, 15, 18, 
	25, 31, 36, 42, 43
]

class << self
	attr_accessor :_bel_indicies
	private :_bel_indicies, :_bel_indicies=
end
self._bel_indicies = [
	0, 0, 1, 2, 2, 1, 3, 3, 
	1, 4, 4, 1, 5, 5, 1, 6, 
	6, 1, 8, 8, 9, 9, 9, 9, 
	7, 10, 11, 11, 11, 11, 7, 13, 
	13, 13, 13, 12, 14, 15, 15, 15, 
	15, 12, 1, 1, 0
]

class << self
	attr_accessor :_bel_trans_targs
	private :_bel_trans_targs, :_bel_trans_targs=
end
self._bel_trans_targs = [
	2, 0, 3, 4, 5, 6, 7, 0, 
	7, 8, 11, 8, 0, 10, 12, 10
]

class << self
	attr_accessor :_bel_trans_actions
	private :_bel_trans_actions, :_bel_trans_actions=
end
self._bel_trans_actions = [
	0, 0, 0, 0, 0, 0, 5, 3, 
	0, 7, 16, 1, 13, 7, 10, 1
]

class << self
	attr_accessor :_bel_eof_actions
	private :_bel_eof_actions, :_bel_eof_actions=
end
self._bel_eof_actions = [
	0, 0, 0, 0, 0, 0, 0, 3, 
	3, 13, 13, 0, 0
]

class << self
	attr_accessor :bel_start
end
self.bel_start = 1;
class << self
	attr_accessor :bel_first_final
end
self.bel_first_final = 11;
class << self
	attr_accessor :bel_error
end
self.bel_error = 0;

class << self
	attr_accessor :bel_en_ident
end
self.bel_en_ident = 9;
class << self
	attr_accessor :bel_en_unset
end
self.bel_en_unset = 1;


      # end: ragel        
          end

          def each
            @buffers = {}
            data     = @content.unpack('C*')
            p        = 0
            pe       = data.length
            eof      = data.length

      # begin: ragel        
            
begin
	p ||= 0
	pe ||= data.length
	cs = bel_start
end

            
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _bel_key_offsets[cs]
	_trans = _bel_index_offsets[cs]
	_klen = _bel_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p].ord < _bel_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _bel_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _bel_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p].ord < _bel_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _bel_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _bel_indicies[_trans]
	cs = _bel_trans_targs[_trans]
	if _bel_trans_actions[_trans] != 0
		_acts = _bel_trans_actions[_trans]
		_nacts = _bel_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _bel_actions[_acts - 1]
when 0 then
		begin

    @buffers[:ident] = []
  		end
when 1 then
		begin

    (@buffers[:ident] ||= []) << data[p].ord
  		end
when 2 then
		begin

    @buffers[:ident] = identifier(utf8_string(@buffers[:ident]))
  		end
when 3 then
		begin

    yield @buffers[:ident]
  		end
when 4 then
		begin

    unless @buffers[:ident].is_a?(::AST::Node)
      @buffers[:ident] ||= []
      @buffers[:ident]   = identifier(utf8_string(@buffers[:ident]).sub(/\n$/, ''))
    end
  		end
when 5 then
		begin

    @buffers[:ident] ||= []
    yield @buffers[:ident]
  		end
when 6 then
		begin

    @buffers[:unset] = unset()
  		end
when 7 then
		begin

    @buffers[:unset] = @buffers[:unset] << name(@buffers[:ident])
  		end
when 8 then
		begin

    yield @buffers[:unset]
  		end
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if p == eof
	__acts = _bel_eof_actions[cs]
	__nacts =  _bel_actions[__acts]
	__acts += 1
	while __nacts > 0
		__nacts -= 1
		__acts += 1
		case _bel_actions[__acts - 1]
when 4 then
		begin

    unless @buffers[:ident].is_a?(::AST::Node)
      @buffers[:ident] ||= []
      @buffers[:ident]   = identifier(utf8_string(@buffers[:ident]).sub(/\n$/, ''))
    end
  		end
when 5 then
		begin

    @buffers[:ident] ||= []
    yield @buffers[:ident]
  		end
		end # eof action switch
	end
	if _trigger_goto
		next
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end

      # end: ragel        
          end
        end
      end
    end
  end
end

if __FILE__ == $0
  $stdin.each_line do |line|
    BELParser::Parsers::BELScript::Unset.parse(line) { |obj|
      puts obj.inspect
    }
  end
end

# vim: ft=ruby ts=2 sw=2:
# encoding: utf-8