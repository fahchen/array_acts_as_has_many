module ArrayActsAsHasMany
  class AssociationProxy
    attr_accessor :target, :klass, :column_name,
      :load_collection

    def initialize(target, klass, column_name)
      @target, @klass, @column_name = target, klass, column_name

      @load_collection = @klass.where(id: @target.send(@column_name))
    end

    def ==(other)
      @load_collection == other
    end

    def <<(record)
      @target.send(@column_name) << record.id
      @target.save
      self
    end

    def equal(records)
      @target.send("#{@column_name}=", records.map(&:id))
      @target.save
      self
    end

    def size
      @load_collection.size
    end
    alias_method :count, :size
    alias_method :length, :size

    def reload
      @load_collection = @klass.where(id: @target.send(@column_name))
    end

    def delete(record)
      @target.send("#{@column_name}=", (@target.send(@column_name) - [record.id]))
      @target.save
      reload
      self
    end

    def include?(record)
      @load_collection.include? record
    end
  end
end
