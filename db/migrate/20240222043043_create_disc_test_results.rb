class CreateDiscTestResults < ActiveRecord::Migration[7.0]
  def change
    create_table :disc_test_results do |t|
      t.integer :dominance
      t.integer :influence
      t.integer :steadiness
      t.integer :compliance
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
