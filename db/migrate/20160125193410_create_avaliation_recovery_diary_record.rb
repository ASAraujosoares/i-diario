class CreateAvaliationRecoveryDiaryRecord < ActiveRecord::Migration[5.2]
  def change
    create_table :avaliation_recovery_diary_records do |t|
      # Disable default index creation because we add explicit unique indexes below
      t.references :recovery_diary_record, foreign_key: true, index: false
      t.references :avaliation, foreign_key: true, index: false
    end

    begin
      unless index_exists?(:avaliation_recovery_diary_records, :recovery_diary_record_id, name: :index_avaliation_recovery_diary_records_on_recovery_diary_id)
        add_index(
          :avaliation_recovery_diary_records,
          :recovery_diary_record_id,
          unique: true,
          name: :index_avaliation_recovery_diary_records_on_recovery_diary_id
        )
      end
    rescue ActiveRecord::StatementInvalid, ArgumentError
      # Ignore if index exists
    end

    begin
      unless index_exists?(:avaliation_recovery_diary_records, :avaliation_id)
        add_index(
          :avaliation_recovery_diary_records,
          :avaliation_id,
          unique: true
        )
      end
    rescue ActiveRecord::StatementInvalid, ArgumentError
      # Ignore if index exists
    end

  end
end
