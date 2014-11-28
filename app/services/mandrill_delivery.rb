require "mandrill"

class MandrillDelivery
  attr_accessor :message

  def initialize(mail)
  end

  def deliver!(mail)
    build_meta_mandrill(mail)
    if mail[:plaintext]
      send_mandrill_in_plaintext(mail)
    else
      send_mandrill(mail)
    end
  end

  def build_meta_mandrill(mail)
    from = mail["from"].value

    # If it has a person name like "\"Natalie\" <natalie@littlelistapp.com>"
    if from.include?("\" ")
      from_name = from.split("\" ").first.gsub("\"", "")
      from_email = from.split("\" ").last.gsub(/[<>]/, "")
    else
      from_name = "Liz and Nathan"
      from_email = from
    end

    # Build Mandrill message hash
    @message = {
      from_name: from_name,
      from_email: from_email,
      subject: mail["subject"],
      headers: {
        "Reply-To" => mail["reply_to"],
      },
      to: [
        {
          email: mail["to"],
          name: mail["name"]
        }
       ],
      auto_text: true,
      tags: [
        mail["tag"]
      ]
    }

    true
  end

  # Sends email via Mandrill with no template
  def send_mandrill_in_plaintext(mail)
    m = Mandrill::API.new(ENV["MANDRILL_API_KEY"])
    @message[:text] = mail.body
    @message[:auto_text] = nil
    sending = m.messages.send(@message)
  end

  # Sends email via Mandrill
  def send_mandrill(mail)
    template = mail[:template] || "default"
    m = Mandrill::API.new(ENV["MANDRILL_API_KEY"])

    sending = m.messages.send_template(
      template,
      [
        {
          name: "main",
          content: "#{mail.body}"
        },
        {
          name: "tagline",
          content: "#{mail["tagline"]}"
        }
      ],
      message = @message
    )
  end

end
