class CreateKnowledgeAreaLessonPlanKnowledgeAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :knowledge_area_lesson_plan_knowledge_areas do |t|
      # Short explicit index name: 'idx_kalp_ka_on_kalp_id'
      t.references :knowledge_area_lesson_plan, index: { name: 'idx_kalp_ka_on_kalp_id' }

      # Short explicit index name: 'idx_kalp_ka_on_ka_id'
      t.references :knowledge_area, index: { name: 'idx_kalp_ka_on_ka_id' }

      t.timestamps
    end

    # Add foreign keys if they were intended (optional but good practice if references exist)
    # add_foreign_key :knowledge_area_lesson_plan_knowledge_areas, :knowledge_area_lesson_plans
    # add_foreign_key :knowledge_area_lesson_plan_knowledge_areas, :knowledge_areas
  end
end
