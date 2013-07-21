FactoryGirl.create(:course, name: 'Math')
FactoryGirl.create(:course, name: 'English')

4.times do
  FactoryGirl.create :to_do
end
