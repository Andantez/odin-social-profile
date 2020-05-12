# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_index :comments, %i[post_id user_id]
  end
end
