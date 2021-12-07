module Users

  # The module provide simple stuff for checking arguments.
  # You can place all shared checking policies here as well
  #   as using it for peculiar checking needs.
  #
  # @example Checking arguments inside constructor
  #   require 'argchkr'
  #
  #   class User
  #     attr_reader :name
  #
  #     def initialize(name)
  #       # it will raise ArgumentError unless str match String50
  #       @name = String50.chk!("name")
  #     end
  #
  #     String50 = Policy.new("string", ":%s must be String[5,50]",
  #       Proc.new {|v| v.is_a?(String) && v.length.between?(5,50)})
  #   end
  module ArgChkr

    # The class provides ability to build your own checking polices
    # @param aname [String] stands for the name of the checking argument
    # @param amessage [String] stands for the message of ArgumentError
    # @param block [Proc] stands for the code that checks the argument
    #
    # @example Create a policy for string[5,50]
    #    String50 = Policy.new("string", ":%s must be String[5,50]",
    #       Proc.new {|v| v.is_a?(String) && v.length.between?(5,50)})
    #
    # @example Usage of the string policy
    #    str = String50.chk!("abcde")
    #    # => str == "abcde"
    #    str = String50.chk!("abcd", "user_name")
    #    # =>  ArgumentError: :user_name must be String[5, 50]
    class Policy
      # Creates policy class
      # @param aname [String] general name of the cheking argument
      # @param ameesage [String] the template of error message
      # @return [Users::ArgChkr::Policy]
      def self.new(aname, amessage, block)
        Class.new do
          define_singleton_method "valid?" do |value|
            block.call(value)
          end

          define_singleton_method "chk!" do |value, name: aname, message: amessage|
            raise ArgumentError, message % name, caller[0..-1] unless valid?(value)
            value
          end
        end
      end
    end

    EmailChkr = Policy.new(
      "email", ":%s must be valid email String[5, 50]",
      ->(v) {
        rx = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
        v.is_a?(String) && v.length.between?(5,50) && rx =~ v
      })

    UserNameChkr = Policy.new(
      "user_name", ":%s must be String[3,50]",
      ->(v) { v.is_a?(String) && v.length.between?(3, 50) })

    PasswordChkr = Policy.new(
      "password", ":%s must be String[8,50]",
      ->(v) { v.is_a?(String) && v.length.between?(8, 50) })

    MoreThanZero = Policy.new(
      "argument", ":%s must be Integer > 0",
      ->(v) { v.is_a?(Integer) && v > 0 })

  end
end
