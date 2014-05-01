require 'spec_helper'

describe UserMailer do
  let(:user) { FactoryGirl.create :user }

  describe '#new_user' do
    let(:mail) { UserMailer.new_user user }

    it 'has a recipient' do
      mail.to.should eq [user.email]
    end

    it 'has a sender' do
      mail.from.should eq [I18n.t(:noreply_email)]
    end

    it 'has a subject' do
      mail.subject.should eq "#{I18n.t :app_name} sign up"
    end
  end

  describe '#email_update' do
    let(:mail) { UserMailer.user_update user }

    it 'has a recipient' do
      mail.to.should eq [user.email]
    end

    it 'has a sender' do
      mail.from.should eq [I18n.t(:noreply_email)]
    end

    it 'has a subject' do
      mail.subject.should eq "#{I18n.t :app_name} user update"
    end
  end

  describe '#password_update' do
    let(:mail) { UserMailer.password_update user }

    it 'has a recipient' do
      mail.to.should eq [user.email]
    end

    it 'has a sender' do
      mail.from.should eq [I18n.t(:noreply_email)]
    end

    it 'has a subject' do
      mail.subject.should eq "#{I18n.t :app_name} password update"
    end
  end
end
