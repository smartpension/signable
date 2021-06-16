# frozen_string_literal: true

module Signable
  module Model
    Embed = Struct.new(:name, :options) do
      include Signable::Concerns::Prefix

      def embed_class
        "Signable::#{name.to_s.classify}".constantize
      end
    end
  end
end
