class Survey < ActiveRecord::Base
  has_and_belongs_to_many(:questions)

  before_save(:capitalize_first)



private
  define_method (:capitalize_first) do
    self.name=(self.name().capitalize())
  end
end
