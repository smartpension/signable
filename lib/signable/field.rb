module Signable
  class Field
    include Signable::Concerns::Common

    column :id
    column :merge
    column :type

  end
end
