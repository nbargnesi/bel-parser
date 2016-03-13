
# begin: ragel


# end: ragel

require          'ast'
require_relative 'nonblocking_io_wrapper'

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
    include AST::Sexp

    def initialize(content)
      @content = content
# begin: ragel        
      
class << self
	attr_accessor :_identifier_actions
	private :_identifier_actions, :_identifier_actions=
end
self._identifier_actions = [
	0, 1, 1, 1, 2, 2, 0, 1
]

class << self
	attr_accessor :_identifier_key_offsets
	private :_identifier_key_offsets, :_identifier_key_offsets=
end
self._identifier_key_offsets = [
	0, 0, 7, 15
]

class << self
	attr_accessor :_identifier_trans_keys
	private :_identifier_trans_keys, :_identifier_trans_keys=
end
self._identifier_trans_keys = [
	95, 48, 57, 65, 90, 97, 122, 10, 
	95, 48, 57, 65, 90, 97, 122, 0
]

class << self
	attr_accessor :_identifier_single_lengths
	private :_identifier_single_lengths, :_identifier_single_lengths=
end
self._identifier_single_lengths = [
	0, 1, 2, 0
]

class << self
	attr_accessor :_identifier_range_lengths
	private :_identifier_range_lengths, :_identifier_range_lengths=
end
self._identifier_range_lengths = [
	0, 3, 3, 0
]

class << self
	attr_accessor :_identifier_index_offsets
	private :_identifier_index_offsets, :_identifier_index_offsets=
end
self._identifier_index_offsets = [
	0, 0, 5, 11
]

class << self
	attr_accessor :_identifier_indicies
	private :_identifier_indicies, :_identifier_indicies=
end
self._identifier_indicies = [
	0, 0, 0, 0, 1, 2, 3, 3, 
	3, 3, 1, 1, 0
]

class << self
	attr_accessor :_identifier_trans_targs
	private :_identifier_trans_targs, :_identifier_trans_targs=
end
self._identifier_trans_targs = [
	2, 0, 3, 2
]

class << self
	attr_accessor :_identifier_trans_actions
	private :_identifier_trans_actions, :_identifier_trans_actions=
end
self._identifier_trans_actions = [
	5, 0, 3, 1
]

class << self
	attr_accessor :identifier_start
end
self.identifier_start = 1;
class << self
	attr_accessor :identifier_first_final
end
self.identifier_first_final = 3;
class << self
	attr_accessor :identifier_error
end
self.identifier_error = 0;

class << self
	attr_accessor :identifier_en_identifier
end
self.identifier_en_identifier = 1;


# end: ragel        
    end

    def each
      buffer = []
      data = @content.unpack('C*')
      p   = 0
      pe  = data.length

# begin: ragel        
      
begin
	p ||= 0
	pe ||= data.length
	cs = identifier_start
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
	_keys = _identifier_key_offsets[cs]
	_trans = _identifier_index_offsets[cs]
	_klen = _identifier_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p].ord < _identifier_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _identifier_trans_keys[_mid]
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
	  _klen = _identifier_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p].ord < _identifier_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _identifier_trans_keys[_mid+1]
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
	_trans = _identifier_indicies[_trans]
	cs = _identifier_trans_targs[_trans]
	if _identifier_trans_actions[_trans] != 0
		_acts = _identifier_trans_actions[_trans]
		_nacts = _identifier_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _identifier_actions[_acts - 1]
when 0 then
		begin
 buffer = []  		end
when 1 then
		begin
 buffer << data[p].ord 		end
when 2 then
		begin

    value = buffer.pack('C*').force_encoding('utf-8')
    yield s(:identifier, value)
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

if __FILE__ == $0
  $stdin.each_line do |line|
    Identifier.parse(line) { |obj|
      puts obj
    }
  end
end

# vim: ft=ruby ts=2 sw=2:
# encoding: utf-8