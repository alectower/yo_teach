class EmailJob
  include SuckerPunch::Job

  def perform(email)
    email.deliver
  end
end
