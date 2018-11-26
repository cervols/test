module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, validation, arg = nil)
      @validations ||= { presence: [], format: [], type: [] }

      case validation
      when :presence
        @validations[:presence] << { attr: name }
      when :format
        @validations[:format] << { attr: name, format: arg }
      when :type
        @validations[:type] << { attr: name, type: arg }
      else
        raise 'Wrong validation type'
      end
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
      validate_attributes_presence
      validate_attributes_format
      validate_attributes_type
    end

    def validate_attributes_presence
      self.class.validations[:presence].each do |attribute|
        attribute_name = attribute[:attr]
        attribute_value = instance_variable_get("@#{attribute_name}")
        raise "#{attribute_name} cannot be nil" if attribute_value.nil?
      end
    end

    def validate_attributes_format
      self.class.validations[:format].each do |attribute|
        attribute_name = attribute[:attr]
        attribute_format = attribute[:format]
        attribute_value = instance_variable_get("@#{attribute_name}")
        raise "#{attribute_name} has an invalid format" if attribute_value !~ attribute_format
      end
    end

    def validate_attributes_type
      self.class.validations[:type].each do |attribute|
        attribute_name = attribute[:attr]
        attribute_type = attribute[:type]
        attribute_value = instance_variable_get("@#{attribute_name}")
        raise "#{attribute_name} has an invalid class" unless attribute_value.is_a?(attribute_type)
      end
    end
  end
end
