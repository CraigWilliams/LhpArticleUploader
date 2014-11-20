#
#  Applescript.rb
#  LhpArticleUploader
#
#  Created by Craig Williams on 2/17/13.
#  Copyright 2013 Craig Williams. All rights reserved.
#

class Applescript
  def self.execute(script)
    `/usr/bin/osascript -e '#{script}'`
  end

  def self.quarkArticle
    script = %{
      tell application "QuarkXPress"
        try
          set theBoxes to generic boxes of selection
          set body to text of item 1 of theBoxes
          set num to text of item 2 of theBoxes
          return num & "|" & body
        on error
          return ""
        end try
      end tell
    }

    execute(script)
  end
end
