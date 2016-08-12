//
//  QuoteCell.swift
//  Cite
//
//  Created by David Everlöf on 07/08/16.
//
//

import Foundation

class QuoteCell: UITableViewCell
{
  static let kReusableIdentifier = "QuoteCell"
  
  let quoteLabel = UILabel()
  let authorLabel = UILabel()
  let leftQuote = UIImageView()
  let rightQuote = UIImageView()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  func setup() {
    authorLabel.translatesAutoresizingMaskIntoConstraints = false
    leftQuote.translatesAutoresizingMaskIntoConstraints = false
    rightQuote.translatesAutoresizingMaskIntoConstraints = false
    quoteLabel.translatesAutoresizingMaskIntoConstraints = false
    
    leftQuote.image = UIImage(named: "ic_quotes_left")
    leftQuote.alpha = 0.3
    
    rightQuote.image = UIImage(named: "ic_quotes_right")
    rightQuote.alpha = 0.3
    
    authorLabel.font = UIFont.citeFontOfSize(16.0)
    authorLabel.textColor = UIColor.darkGrayColor()
    authorLabel.text = "-"
    
    let quoteFontSize: CGFloat = 18.0
    quoteLabel.textAlignment = .Center
    quoteLabel.font = UIFont.citeItalicFontOfSize(quoteFontSize)
    quoteLabel.text = "-"
    quoteLabel.textColor = UIColor.darkGrayColor()
    quoteLabel.numberOfLines = 0
    
    contentView.addSubview(quoteLabel)
    contentView.addSubview(authorLabel)
    contentView.addSubview(leftQuote)
    contentView.addSubview(rightQuote)
    
    NSLayoutConstraint(item: quoteLabel, attribute: .Left, relatedBy: .GreaterThanOrEqual, toItem: contentView, attribute: .Left, multiplier: 1.0, constant: 36.0).active = true
    NSLayoutConstraint(item: quoteLabel, attribute: .Right, relatedBy: .LessThanOrEqual, toItem: contentView, attribute: .Right, multiplier: 1.0, constant: 36.0).active = true
    
    NSLayoutConstraint(item: quoteLabel, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
    NSLayoutConstraint(item: quoteLabel, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 18.0).active = true
    NSLayoutConstraint(item: quoteLabel, attribute: .Bottom, relatedBy: .Equal, toItem: authorLabel, attribute: .Bottom, multiplier: 1.0, constant: -36.0).active = true
    
    // Place it in the bottom right of the cell
    NSLayoutConstraint(item: authorLabel, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1.0, constant: -18.0).active = true
    NSLayoutConstraint(item: authorLabel, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: -18.0).active = true
    
    // Place it left of the quoteLabel
    NSLayoutConstraint(item: leftQuote, attribute: .Top, relatedBy: .Equal, toItem: quoteLabel, attribute: .Top, multiplier: 1.0, constant: -quoteFontSize/3.0).active = true
    NSLayoutConstraint(item: leftQuote, attribute: .Right, relatedBy: .Equal, toItem: quoteLabel, attribute: .Left, multiplier: 1.0, constant: -9.0).active = true
    
    // Place it right of the quotelabel
    NSLayoutConstraint(item: rightQuote, attribute: .Bottom, relatedBy: .Equal, toItem: quoteLabel, attribute: .Bottom, multiplier: 1.0, constant: quoteFontSize/3).active = true
    NSLayoutConstraint(item: rightQuote, attribute: .Left, relatedBy: .Equal, toItem: quoteLabel, attribute: .Right, multiplier: 1.0, constant: 9.0).active = true
    
    leftQuote.hidden = true
    rightQuote.hidden = true
  }
  
  func configureFor(q: Quote) -> UITableViewCell {
    let quote = q.quote ?? "-"
    let author = q.author ?? "Unknown"
    let date = q.created ?? NSDate()
    
    struct TimeFormatter {
      static let formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        formatter.dateFormat = "LLL yyy"
        return formatter
      }()
    }
    
    quoteLabel.text = "“\(quote)”"
    authorLabel.text = "- \(author), \(TimeFormatter.formatter.stringFromDate(date))"
    
    return self
  }
}