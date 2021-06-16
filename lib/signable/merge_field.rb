# frozen_string_literal: true

module Signable
  class MergeField

    include Signable::Concerns::Model

    # Must be before the columns call because the column class method use
    # the prefix method
    def self.prefix
      'field'
    end

    column :id
    column :merge
    column :value

  end
end
