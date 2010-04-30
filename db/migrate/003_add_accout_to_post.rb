migration 3, :add_accout_to_post do
  up do
modify_table :posts do
  add_column :account_id, Integer
end
  end

  down do
modify_table :posts do
  drop_column :account_id
end
  end
end
