module Signable
  class Field
    include Signable::Concerns::Model

    column :id
    column :merge
    column :type

  end
end
