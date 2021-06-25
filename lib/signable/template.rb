# frozen_string_literal: true

module Signable
  class Template < Signable::Base

    column :id
    column :fingerprint
    column :title
    embed :parties

    def save
      raise 'not available'
    end

    def update
      raise 'not available'
    end

    def delete
      raise 'not available'
    end

    def remind
      raise 'not available'
    end

  end
end
