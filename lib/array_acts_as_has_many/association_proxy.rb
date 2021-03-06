module ArrayActsAsHasMany
  class AssociationProxy
    include Enumerable

    attr_accessor :target, :klass, :column_name,
      :load_collection, :options

    def initialize(target, klass, column_name, options = {})
      @target, @klass, @column_name, @options = target, klass, column_name, options

      @load_collection = @klass.where(id: @target.send(@column_name))
    end

    def each
      @load_collection.each { |record| yield record }
    end

    def ==(other)
      @load_collection == other
    end

    def <<(record)
      @target.send(@column_name) << record.id
      @target.save
      reload
      self
    end

    def equal(records)
      @target.send("#{@column_name}=", records.map(&:id))
      @target.save
      reload
      self
    end

    def size
      @load_collection.size
    end
    alias_method :count, :size
    alias_method :length, :size

    # Also should be reloaded by target
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
