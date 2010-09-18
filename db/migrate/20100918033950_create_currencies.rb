class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.boolean :popular
      t.string :name
      t.decimal :rate, :precision => 10, :scale => 4

      t.timestamps
    end
  end

  def self.down
    drop_table :currencies
  end
end
