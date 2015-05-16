class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.decimal :amount

      t.timestamps
    end
  end
end
