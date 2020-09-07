module Signable
  class Party
    include Signable::Concerns::Model

    column :id, presence: true
    column :name, presence: true
    column :email, presence: true
    column :contact_email
    column :signing_url
    column :message

    embed :merge_fields
  end
end
