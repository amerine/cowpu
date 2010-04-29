migration 2, :create_posts do
  up do
    create_table :posts do
      column :id, Integer, :serial => true
      column :title, "STRING"
      column :body, "TEXT"
      column :slug, "STRING"
      column :created_at, "DATETIME"
    end
  end

  down do
    drop_table :posts
  end
end
