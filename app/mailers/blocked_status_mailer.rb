class BlockedStatusMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.blocked_status_mailer.blocked_notice.subject
  #
  def blocked_notice(user, business)
    @user = user
    @business = business

     mail(
      from: "no-reply@therecord.org",
      to: @user.email,
      subject: "You have been blocked from #{@business.name} business"
    )
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.blocked_status_mailer.unblocked_notice.subject
  #
  def unblocked_notice(user, business)
    @user = user
    @business = business

    mail(
      from: "no-reply@therecord.org",
      to: @user.email,
      subject: "You have been unblocked from #{@business.name} business"
    )
  end
end
