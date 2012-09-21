class CreateColleges < ActiveRecord::Migration
  def self.up
    create_table :colleges do |t|
      t.string :college_Name
      t.string :code
      t.text :address
      t.integer :establish_Year

      t.timestamps
    end
  end

  def self.down
    drop_table :colleges
  end
end
