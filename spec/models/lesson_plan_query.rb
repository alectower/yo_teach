require 'spec_helper'

describe LessonPlanQuery do
  before do
    @query_object = LessonPlanQuery.new
  end
  it "can be found by title" do
    results = @query_object.search(search: 'area')
    results.size.should eq(1)
  end

  it "can be found by partial title" do
    results = @query_object.search(search: 'are')
    results.size.should eq(2)
  end

  it "cannot be found with blank search terms" do
    results = @query_object.search(search: '')
    results.size.should eq(3)
  end

  it "cannot be found with nil search terms" do
    results = @query_object.search(search: nil)
    results.size.should eq(3)
  end

  it 'can be found by course id' do
    @query_object.search(course: 1).size.should eq(2)
  end

  it 'can be sorted by title column' do
    @query_object.search(sort: 'title').should eq [@area, @circumference, @dare]
  end

  it 'can be sorted by course name' do
    @query_object.search(sort: 'course_name').should eq [@dare, @area, @circumference]
  end

  it 'can be sorted in reverse' do
    @query_object.search(sort: 'title', direction: 'desc').should eq [@dare, @circumference, @area]
  end

  it 'can filter and sort' do
    @query_object.search(course: 1, sort: 'title').should eq [@area, @circumference]
  end

  it 'can search and sort in reverse' do
    @query_object.search(search: 'are', sort: 'title', direction: 'desc').should eq [@dare, @area]
  end
end
