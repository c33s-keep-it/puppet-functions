#
# has_value.rb
#
# Copyright 2012 Krzysztof Wilczynski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Puppet::Parser::Functions
  newfunction(:has_value, :type => :rvalue, :doc => <<-EOS
Returns true if given hash contains particular value and false otherwise.

Prototype:

    has_value(h, x)

Where h is a hash type and x is a value of an arbitrary type.

For example:

  Given the following statements:

    $a = { 'a' => 1, 'b' => 2, 'c' => 3 }
    $b = { 'def' => 123, 'xyz' => 456 }

    notice has_value($a, 1)
    notice has_value($b, 111)

  The result will be as follows:

    notice: Scope(Class[main]): true
    notice: Scope(Class[main]): false
    EOS
  ) do |*arguments|
    #
    # This is to ensure that whenever we call this function from within
    # the Puppet manifest or alternatively form a template it will always
    # do the right thing ...
    #
    arguments = arguments.shift if arguments.first.is_a?(Array)

    raise Puppet::ParseError, "has_value(): Wrong number of arguments " +
      "given (#{arguments.size} for 2)" if arguments.size < 1

    hash = arguments.shift

    raise Puppet::ParseError, 'has_value(): Requires a hash type ' +
      'to work with' unless hash.is_a?(Hash)

    value = arguments.shift

    hash.has_value?(value)
  end
end

# vim: set ts=2 sw=2 et :
# encoding: utf-8
