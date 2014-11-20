#
#  Alert.rb
#  LhpArticleUploader
#
#  Created by Craig Williams on 2/17/13.
#  Copyright 2013 Craig Williams. All rights reserved.
#

class Alert

  def initialize(window)
    @window = window
  end

  def render
    alert = NSAlert.alloc.init
    alert.addButtonWithTitle "OK"
    alert.setMessageText "No Boxes Selected"
    alert.setInformativeText "You must select the article number and article body boxes in Quark"
    alert.setAlertStyle NSWarningAlertStyle

    alert.beginSheetModalForWindow(@window, modalDelegate: self, didEndSelector: "alertDidEnd:returnCode:contextInfo:", contextInfo: nil)
  end

  def alertDidEnd(alert, returnCode: returnCode, contextInfo: contextInfo)
    puts "ReturnCode: #{returnCode}\nContextInfo: #{contextInfo}"
  end

end
