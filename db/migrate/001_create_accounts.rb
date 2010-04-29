migration 1, :create_accounts do
  up do
create_table :accounts do
  column :id, Integer, :serial => true
  column :name, "STRING"
      column :surname, "STRING"
      column :email, "STRING"
      column :crypted_password, "STRING"
      column :salt, "STRING"
      column :role, "STRING"
end
  end

  down do
    drop_table :accounts
  end
end
