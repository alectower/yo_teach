require 'spec_helper'

describe ApplicationHelper do

  context 'table that allows column sorting' do

    it 'uses column name for link if title isn\'t given' do
      sortable(column: 'course', controller: 'lesson_plans').should eq "<a href=\"/lesson_plans?direction=asc&amp;sort=course\">Course</a>"
    end

    it 'sorts descending if same column is sorted twice' do
      controller.params[:sort] = 'course'
      controller.params[:direction] = 'asc'
      sortable(column: 'course', controller: 'lesson_plans').should eq "<a href=\"/lesson_plans?direction=desc&amp;sort=course\">Course</a>"
    end

  end

  context 'sort image' do
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
