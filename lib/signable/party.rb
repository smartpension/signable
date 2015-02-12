module Signable
  class Party
    include Signable::Concerns::Model

    column :id, presence: true
    column :name, presence: true
    column :email, presence: true

    embed :merge_fields
  end
end
