# frozen_string_literal: true

module Signable
  List = Struct.new(:data_type, :raw_data) do
    def offset
      raw_data['offset']
    end

    def limit
      raw_data['limit']
    end

    def total
      raw_data["total_#{data_name}"]
    end

    def data
      @data ||= raw_data[data_name].map { |attributes| data_type.new attributes }
    end

    private

    def data_name
      data_type.name.demodulize.underscore.pluralize
    end
  end
end
