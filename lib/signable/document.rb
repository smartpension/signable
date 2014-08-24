module Signable
  class Field
    include Signable::Concerns::Model

    column :fingerprint
    column :title
    column :page_total
    column :pdf_url
    column :thumbnails
    column :pages

  end
end
