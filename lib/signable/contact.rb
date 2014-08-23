module Signable
  class Contact < Signable::Base

    column :id
    column :name, presence: true
    column :email, presence: true
    column :added
    column :outstanding_documents
  end
end
