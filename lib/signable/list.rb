module Signable
  class List < Struct.new(:data_type, :hash)

    def offset
      hash['offset']
    end

    def limit
      hash['limit']
    end

    def total
      hash["total_#{data_name}"]
    end

    def data
      @data ||= hash[data_name].map { |attributes| data_type.new attributes }
    end

    private

    def data_name
      data_type.name.demodulize.underscore.pluralize
    end

  end
end
