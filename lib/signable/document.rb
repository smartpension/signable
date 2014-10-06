module Signable
  class Document
    include Signable::Concerns::Model

    column :template_fingerprint, presence: true
    column :title, presence: true

  end
end
