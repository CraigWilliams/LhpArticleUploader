#
#  MainWindowController.rb
#  LhpArticleUploader
#
#  Created by Craig Williams on 2/17/13.
#  Copyright 2013 Craig Williams. All rights reserved.
#

class MainWindowController
  attr_accessor :articleNumber, :articleTitle, :articleBody, :articleTags
  attr_accessor :uploadButton, :spinner, :window

  def uploadButton(sender)
    sender.title = "Processing..."
    sender.setEnabled false
    startSpinner
    Request.new(prepareArticle, self).send
  end

  def fromQuarkButton(sender)
    @article = Applescript.quarkArticle
    parseArticle
  end

  def parseArticle
    if @article == "\n"
      Alert.new(window).render
    else
      first, second = @article.split("|")

      if first.size < 10
        number = first
        body = second
      else
        body = first
        number = second
      end

      body = body.gsub("\r", "\n")
      parts = body.split("\n")
      title = parts.first
      body = parts[1..-1].join("\n")

      articleNumber.stringValue = number
      articleTitle.stringValue  = title
      articleBody.string        = body
    end
  end

  def prepareArticle
    {
      article: {
        number: articleNumber.stringValue(),
        title: articleTitle.stringValue(),
        body: articleBody.string(),
        tag_list: articleTags.stringValue()
      }
    }
  end

  def success
    @uploadButton.title = "Upload"
    @uploadButton.setEnabled true
    stopSpinner
    clearFields
  end

  def failure
    stopSpinner
  end

  def clearFields
    articleNumber.stringValue = ''
    articleTitle.stringValue  = ''
    articleBody.string        = ''
  end

  def startSpinner
    spinner.startAnimation nil
  end

  def stopSpinner
    spinner.stopAnimation nil
  end
end
