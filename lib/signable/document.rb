module Signable
  class Document
    include Signable::Concerns::Model

    column :template_fingerprint, presence: true
    column :title, presence: true
    column :pdf_url
    column :pages

    def page
      pages.first
    end

  end
end
