require 'prime'

Plugin.create :mikutter_prime_number do
  def has_prime?(msg)
    if msg.to_s =~ /(\d+)/
      Prime.prime?($1.to_i) ? $1 : false
    end
  end

  on_update do |service, msgs|
    msgs.each do |msg|
      if num = has_prime?(msg)
        link = "http://twitter.com/#{msg.user}/status/#{msg.id}"
        Service.primary.post message: "ピピーッ 素数 #{num} を発見しました！ #{link}"
      end
    end
    [service, msgs]
  end
end
