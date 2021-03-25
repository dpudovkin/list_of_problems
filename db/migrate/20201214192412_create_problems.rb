class CreateProblems < ActiveRecord::Migration[6.0]
  def change
    create_table :problems do |t|
      t.string :title
      t.string :text
      t.float :answer
      t.string :author
      t.string :integer

      t.timestamps
    end
  end
end
