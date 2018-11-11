module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances, :all
  end

  module InstanceMethods
    protected

    def register_instance(index)
      self.class.all ||= {}
      self.class.all[index] = self

      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end
