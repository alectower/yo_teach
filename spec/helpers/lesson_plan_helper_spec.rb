require 'spec_helper'

describe LessonPlanHelper do
  before :each do
    @lesson_plan = FactoryGirl.create(:lesson_plan)
  end

  context 'lesson plan status is empty' do
    it 'assigns lesson status class' do
      helper.status_class.should eq 'badge badge-important'
    end
  end

  context 'lesson plan status is in progress' do
    it 'assigns lesson status class' do
      @lesson_plan.status = 2
      helper.status_class.should eq 'badge badge-warning'
    end
  end

  context 'lesson plan status is complete' do
    it 'assigns lesson status class' do
      @lesson_plan.status = 3
      helper.status_class.should eq 'badge badge-success'
    end
  end

  context 'lesson plan status is nil' do
    it 'assigns lesson status class' do
      @lesson_plan.status = nil
      helper.status_class.should eq nil
    end
  end
end
