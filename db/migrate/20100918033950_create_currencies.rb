class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.boolean :popular
      t.string :name
      t.decimal :rate, precision: 10, scale: 4

      t.timestamps
    end
  end
end
