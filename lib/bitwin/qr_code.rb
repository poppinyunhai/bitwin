module Bitwin
  module QrCode
    def self.generate(content)
      "http://chart.apis.google.com/chart?cht=qr&chs=300x300&chl=#{content.to_s}&choe=UTF-8"
    end
  end
end