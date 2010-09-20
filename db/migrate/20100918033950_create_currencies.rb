class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string :longname
      t.string :shortname

      t.boolean :popular, :default => false
      t.decimal :rate, :precision => 10, :scale => 4

      t.timestamps
    end
  end

  def self.down
    drop_table :currencies
  end
end
