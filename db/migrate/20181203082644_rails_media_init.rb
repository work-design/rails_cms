class RailsMediaInit < ActiveRecord::Migration[5.2]
  def change

    create_table :videos do |t|
      t.references :author
      t.references :video_taxon
      t.string :title
      t.string :state
      t.integer :liked_count
      t.integer :view_count
      t.integer :comments_count
      t.string :water_mark_job
      t.timestamps
    end

    create_table :audios do |t|
      t.references :author
      t.string :title
      t.string :state
      t.timestamps
    end

    create_table :progressions do |t|
      t.references :user
      t.references :progressive, polymorphic: true
      t.float :rate
      t.float :time
      t.float :duration
      t.string :state
      t.timestamps
    end

  end
end
