#
# prefix_hash_keys.rb
#

module Puppet::Parser::Functions
  newfunction(:prefix_hash_keys, :type => :rvalue, :doc => <<-EOS
This function applies a prefix to all keys in a hash.

*Examples:*

    prefix({'a' => 1,'b' => 2,'c' => 3 }, 'p_')

Will return: {'p_a' => 1,'p_b' => 2,'p_c' => 3 }
    EOS
  ) do |arguments|

    # Technically we support two arguments but only first is mandatory ...
    raise(Puppet::ParseError, "prefix_hash_keys(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    hash = arguments[0]

    unless hash.is_a?(Hash)
      raise Puppet::ParseError, "prefix_hash_keys(): expected first argument to be an Hash, got #{array.inspect}"
    end

    prefix = arguments[1] if arguments[1]

    if prefix
      unless prefix.is_a?(String)
        raise Puppet::ParseError, "prefix_hash_keys(): expected second argument to be a String, got #{prefix.inspect}"
      end
    end

    # Turn everything into string same as join would do ...
    result = Hash[hash.map do |k,v|
      k = k.to_s
      [ prefix ? prefix + k : k, v ]
    end]

    return result
  end
end
