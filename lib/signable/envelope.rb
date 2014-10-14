module Signable
  class Envelope < Signable::Base

    column :title, presence: true
    column :fingerprint
    column :status
    column :signed_pdf
    column :signing_embed
    embed :documents
    embed :parties

    def update
      raise "not available"
    end

    def pdf_url
      first_document.pdf_url
    end

    def page
      first_document.page
    end

    def delete
      raise "not available"
    end

    private

    def first_document
      documents.first
    end
  end
end
