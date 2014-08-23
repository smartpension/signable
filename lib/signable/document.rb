module Signable
  class Field
    include Signable::Concerns::Core

    column :fingerprint
    column :title
    column :page_total
    column :pdf_url
    column :thumbnails
    column :pages

  end
end
