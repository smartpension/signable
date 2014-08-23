module Signable
  class Template < Signable::Base

    column :id, as: :fingerprint
    column :title
    column :page_total
    column :in_progress
    column :parties_total
    column :widget_url
    column :widget_embed
    column :widget_pdf_url
    column :thumbnails
    column :pages
    column :uploaded
    embed :parties

    def save
      raise "not available"
    end

  end
end
