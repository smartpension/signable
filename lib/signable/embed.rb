module Signable
  class Embed < Struct.new(:name, :options)
    include Signable::Concerns::Prefix

    def embed_class
      "Signable::#{name.to_s.classify}".constantize
    end

  end
end
