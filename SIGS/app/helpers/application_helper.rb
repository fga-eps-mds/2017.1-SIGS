module ApplicationHelper
  def flash_message
   messages = ""
   [:notice, :info, :warning, :error].each {|type|
     if flash_message
       messages += flash_message
     end
   }

   messages
 end

 def flash_message
 	flash[type]
 end
end
