class CreateDimensionHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :dimension_histories, id: :uuid do |t|
      t.string :url
      t.datetime :datetime
      t.string :mac_address
      t.integer :result_code
      t.string :result_name
      t.string :width
      t.string :length
      t.string :height
      t.string :weight

      t.timestamps
    end
  end
end
