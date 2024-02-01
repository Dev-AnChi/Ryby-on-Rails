class CreateDimensionHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :dimension_histories, id: false do |t|
      t.bigint :id, primary_key: true
      t.string :url
      t.datetime :datetime
      t.string :mac_address
      t.integer :result_code
      t.string :result_name
      t.string :width
      t.string :length
      t.string :height
      t.string :weight

      # Thêm cấu hình cho cột id
      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
