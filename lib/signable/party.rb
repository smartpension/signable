module Signable
  class Party
    include Signable::Concerns::Common

    column :id
    column :name
    embed :fields, as: :merge_fields

  end
end
