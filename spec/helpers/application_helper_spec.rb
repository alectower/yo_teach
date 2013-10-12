require 'spec_helper'

describe ApplicationHelper do
  before :each do
    controller.request.path_parameters[:controller] = 'lesson_plans'
  end

  context 'table allows column sorting' do
    it 'uses column name for link if title isn\'t given' do
      sortable(sort: 'course').should eq "<a href=\"/lesson_plans?direction=asc&amp;sort=course\">Course</a>"
    end

    it 'sorts descending if same column is sorted twice' do
      controller.params[:sort] = 'course'
      controller.params[:direction] = 'asc'
      sortable(sort: 'course').should eq "<a href=\"/lesson_plans?direction=desc&amp;sort=course\">Course</a>"
    end

    context 'link for one course' do
      it 'adds course to params when specified' do
        sortable(sort: 'status', course: 1).should eq "<a href=\"/lesson_plans?course=1&amp;direction=asc&amp;sort=status\">Status</a>"
      end
    end
  end

  context 'image specifies sort column and direction' do
    context 'default table sort' do
      it 'displays asc sort image on title' do
        sort_image('title').should eq "<i class=\"icon-chevron-down\"></i>"
      end

      it 'does not display image for other columns' do
        sort_image('status').should eq nil
      end
    end

    context 'desc sort on specific column' do
      it 'shows desc sort image' do
        controller.params[:sort] = 'status'
        controller.params[:direction] = 'desc'
        sort_image('status').should eq "<i class=\"icon-chevron-up\"></i>"
      end
    end
  end

end
