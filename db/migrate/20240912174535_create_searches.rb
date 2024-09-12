class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :query, null: false
      t.string :scope, null: false

      t.timestamps
    end
  end
end
