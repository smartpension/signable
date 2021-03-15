module Signable
  class PartyFile

    include ::Signable::Concerns::Model

    ROLES = %w[signer1 signer2].freeze

    column :role, presence: true
    column :email, presence: true
    column :name, presence: true
    column :message

  end
end
