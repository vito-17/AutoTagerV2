class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.references :shop

      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :tags
      t.integer :shopify_customer_id, limit: 8

      t.timestamps
    end
  end
end
