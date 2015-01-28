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
