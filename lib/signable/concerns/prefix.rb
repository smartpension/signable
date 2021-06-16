# frozen_string_literal: true

module Signable
  module Concerns
    module Prefix
      extend ActiveSupport::Concern

      def match?(name)
        [name_without_prefix, name_with_prefix].include? name.to_s
      end

      def name_with_prefix
        "#{prefix}_#{name}"
      end

      def name_without_prefix
        name.to_s.gsub("#{prefix}_", '')
      end

      def prefix
        options[:prefix]
      end
    end
  end
end
