class CreateReportMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :report_mentions do |t|
      t.references :source_report, null: false, foreign_key: { to_table: :reports }
      t.references :target_report, null: false, foreign_key: { to_table: :reports } 
      t.timestamps
    end
  end
end
