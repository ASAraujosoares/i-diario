class CreateKnowledgeAreaLessonPlanKnowledgeAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :knowledge_area_lesson_plan_knowledge_areas do |t|
      # Fix index name too long (PostgreSQL 63 chars limit)
      t.references :knowledge_area_lesson_plan, null: false, index: { name: 'idx_kalp_ka_on_kalp_id' }
      t.references :knowledge_area, null: false
    end

    add_index :knowledge_area_lesson_plan_knowledge_areas,
      [:knowledge_area_lesson_plan_id, :knowledge_area_id],
      unique: true,
      name: 'idx_kalp_ka_on_kalp_id_and_ka_id' # Shortened from 'index_knowledge_areas_on_lesson_plan_id_and_knowledge_area_id'

    add_foreign_key :knowledge_area_lesson_plan_knowledge_areas,
      :knowledge_area_lesson_plans,
      name: 'fk_kalp_ka_on_kalp_id' # Shortened from 'knowledge_area_lesson_plans_knowledge_area_lesson_plan_id_fk'
      
    add_foreign_key :knowledge_area_lesson_plan_knowledge_areas, :knowledge_areas
  end
end
