class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :original_content
      t.text :encrypted_content
      t.integer :encryption_alogrithem, default: 13

      t.timestamps
    end
  end
end
