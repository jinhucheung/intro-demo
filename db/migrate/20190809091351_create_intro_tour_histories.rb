class CreateIntroTourHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :intro_tour_histories do |t|
      t.references :tour, null: false, index: false
      t.references :user, null: false, index: false
      t.integer :touch_count, null: false, default: 0
      t.timestamps null: false
    end

    add_index :intro_tour_histories, [:user_id, :tour_id, :touch_count], name: 'index_intro_tour_histories_on_user_and_tour_and_touch_count'
  end
end