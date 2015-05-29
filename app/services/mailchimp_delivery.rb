class MailchimpDelivery

  LIST_IDS = { "newsletter" => { title: "Ginger and the Cyclist Newsletter", id: "8f0af2650f" } }

  def initialize list 
    @gb = Gibbon::API.new
    @list_id = LIST_IDS[list][:id]
  end

  def subscribe subscriber
    gb.lists.subscribe(
      {:id => list_id, 
       :email => {:email => subscriber.email}, 
       :merge_vars => {:FNAME => subscriber.first_name}, 
       :double_optin => false})
  end

end
