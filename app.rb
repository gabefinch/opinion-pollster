require('bundler/setup')
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

post('/add_survey') do
  name = params.fetch('name')
  Survey.create({ :name => name })
  redirect back
end

get('/survey/:id') do
  @survey = Survey.find(params['id'].to_i)
  erb(:survey)
end

post('/question') do
  ask = params.fetch('ask')
  survey_id = params.fetch('survey_id').to_i()
  @question = Question.create({:ask => ask, :surveys => [Survey.find(survey_id)]})
  redirect back
end

get('/survey_edit/:id') do
  @survey=Survey.find(params.fetch("id").to_i())
  erb(:survey_edit)
end

patch('/survey_change') do
  new_name = params.fetch("new_name")
  survey_id = params.fetch('survey_id').to_i()
  @survey = Survey.find(survey_id)
  @survey.update({:name => new_name})
  redirect('/')
end

delete('/survey_delete') do
  @survey=Survey.find(params.fetch("id").to_i())
  @survey.destroy()
  redirect('/')
end

get ('/edit_question/:question_id/:survey_id') do
  @question = Question.find(params['question_id'].to_i)
  @survey = Survey.find(params['survey_id'].to_i)
  erb(:edit_question)
end

patch('/question_update') do
  new_ask = params.fetch("new_ask")
  question_id = params.fetch("question_id").to_i()
  @question = Question.find(question_id)
  @question.update({:ask => new_ask})
  redirect('/')
end

delete('/question_seperate') do
  question = Question.find(params['question_id'].to_i)
  survey = Survey.find(params['survey_id'].to_i)
  survey.questions.delete(question)
  redirect('/')
end

delete('/question_delete') do
  quest = Question.find(params.fetch("question_id").to_i())
  quest.destroy()
  redirect('/')
end

get('/questions') do
  @questions = Question.all()
  @surveys = Survey.all()
  erb(:questions)
end

post('/new_question') do
  ask = params.fetch("ask")
  question = Question.create({:ask => ask})
  redirect('/questions')
end

post('/choose_question') do
  survey_to_modify = Survey.find(params['survey_id'])
  params['question_ids'].each do |id|
    ques = Question.find(id.to_i())
    survey_to_modify.questions.push(ques)
  end
  redirect ('/')
end
