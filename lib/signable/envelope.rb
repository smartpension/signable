module Signable
  class Envelope < Signable::Base

    column :id, as: :fingerprint
    column :title
    column :status
    column :created
    column :sent
    column :signed_pdf
    embed :documents

    def update
      raise "not available"
    end

    def delete
      raise "not available"
    end
  end
end
