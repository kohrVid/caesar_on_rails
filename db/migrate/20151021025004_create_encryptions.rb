class CreateEncryptions < ActiveRecord::Migration
  def change
    create_table :encryptions do |t|
	    t.string :message
	    t.integer :shift

      t.timestamps null: false
    end
  end
end
