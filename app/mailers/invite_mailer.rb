
class InviteMailer < Devise::Mailer
  def invitation_instructions(user, business_name, inviter_email, opts={})
    @business_name = business_name
    @inviter_email = inviter_email
    devise_mail(user, user.invitation_instructions || :invitation_instructions, opts.merge({subject: "You've been invited to join #{business_name}"}))
  end
end


