class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :body
      #this will generate an integer field called 'question_id'
      #foreign_key: true = > this is the foreign key restraint
      #if you want to create an answer that is linked to e.g. question_id 22, FK restraint first checks that question_id 22 exists in questions table. If you want to delete a question, you first have to delete the related answers.
      t.references :question, foreign_key: true, index:true 

      t.timestamps
    end
  end
end
