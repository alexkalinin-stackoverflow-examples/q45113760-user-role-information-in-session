class AddAuthorToPost < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.references :author, index: true, foreign_key: true
    end
  end
end
