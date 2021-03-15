module Signable
  class DocumentFile

    include ::Signable::Concerns::Model

    column :file_content, presence: true
    column :file_name, presence: true
    column :title, presence: true

  end
end
