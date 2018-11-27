module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, arg = nil)
      @validations ||= { presence: [], format: [], type: [] }
      raise "Wrong validation - #{type}" unless @validations.keys.include?(type)
      @validations[type] << { attr: name, arg: arg }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate!
      return unless self.class.validations

      self.class.validations.each do |type, options|
        options.each do |validation|
          value = instance_variable_get("@#{validation[:attr]}")
          send("validate_#{type}", validation[:attr], value, validation[:arg])
        end
      end
    end

    def validate_presence(attribute, value, _)
      raise "#{attribute} cannot be nil" if value.nil?
    end

    def validate_format(attribute, value, format)
      raise "#{attribute} has an invalid format" if value !~ format
    end

    def validate_type(attribute, value, klass)
      raise "#{attribute} has an invalid class" unless value.is_a?(klass)
    end
  end
end
