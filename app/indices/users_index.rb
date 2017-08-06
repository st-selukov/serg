ThinkingSphinx::Index.define :user, with: :active_record do

  indexes email, as: :author, sortable: true

  has id, created_at, updated_at
end