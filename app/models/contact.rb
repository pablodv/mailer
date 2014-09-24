class Contact
  def self.import(email, token)
    if email && token
      url = URI.parse("https://www.google.com/m8/feeds/contacts/#{email}/full?access_token=#{token}&GData-Version=3.0&alt=json")

      response = Net::HTTP.get_response(url)
      JSON.parse(response.body) if response.code == "200"
    end
  end
end
