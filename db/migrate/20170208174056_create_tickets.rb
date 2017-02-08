class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.text :support_request
      t.integer :status, default: 0
      t.datetime :closed_at
      t.integer :customer_id
      t.integer :support_agent_id

      t.timestamps
    end
  end
end
