# frozen_string_literal: true

module Signable
  class Contact < Signable::Base

    column :id
    column :name, presence: true
    column :email, presence: true

  end
end
