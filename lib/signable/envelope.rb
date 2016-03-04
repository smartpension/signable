module Signable
  class Envelope < Signable::Base

    column :title, presence: true
    column :fingerprint
    column :status
    column :signed_pdf
    column :redirect_url
    embed :documents
    embed :parties

    def update
      raise "not available"
    end

    def delete
      raise "not available"
    end

  end
end
