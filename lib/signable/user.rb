module Signable
  class User < Signable::Base

    column :id
    column :name, presence: true
    column :email, presence: true
    column :added
    column :last_updated
  end
end
