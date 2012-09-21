class CreateUniversities < ActiveRecord::Migration
  def self.up
    create_table :universities do |t|
      t.string :name_of_the_university
      t.string :address

      t.timestamps
    end
  end

  def self.down
    drop_table :universities
  end
end
