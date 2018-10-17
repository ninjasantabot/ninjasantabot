class CreateGame < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :state, :default => "opt_in"
      t.string :name

      t.timestamps
    end
  end
end
