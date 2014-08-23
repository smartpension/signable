module Signable
  module Concerns
    module Embed
      extend ActiveSupport::Concern

      def find_embed(name)
        self.class.embeds.find { |embed| embed.match?(name) }
      end

      module ClassMethods
        def embed(name, options = {})
          embeds << Signable::Embed.new(name, options.merge({ prefix: prefix }))
        end

        def embeds
          @embeds ||= []
        end
      end

    end
  end
end
