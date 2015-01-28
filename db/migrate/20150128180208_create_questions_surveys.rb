class CreateQuestionsSurveys < ActiveRecord::Migration
  def change
    create_table(:questions_surveys) do |t|
      t.column(:question_id, :integer)
      t.column(:survey_id, :integer)

      t.timestamps
    end
  end
end
