class CreateQuestions < ActiveRecord::Migration
  def change
    create_table(:questions) do |q|
      q.column(:ask, :string)

      q.timestamps
    end
  end
end
