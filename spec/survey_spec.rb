require('spec_helper')

describe(Survey) do
  it { should have_and_belong_to_many(:questions) }

  it("ensures that the first letter will be capitalized") do
    survey1 = Survey.create({:name => "monkeys"})
    expect(survey1.name()).to(eq("Monkeys"))
  end
end
