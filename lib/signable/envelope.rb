module Signable
  class Envelope < Signable::Base

    column :id
    column :title, presence: true
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
