class CreateAirports < ActiveRecord::Migration
  def self.up
    create_table :airports do |t|
      t.string :code
      t.string :name
      t.string :city
      t.string :country
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
    add_index :airports, :code
    add_index :airports, :name
    add_index :airports, :city
    add_index :airports, :country
  end

  def self.down
    drop_table :airports
  end
end
