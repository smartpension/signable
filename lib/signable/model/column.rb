# frozen_string_literal: true

module Signable
  module Model
    Column = Struct.new(:name, :options) do
      include Signable::Concerns::Prefix

      def required?
        options[:presence] == true
      end
    end
  end
end
