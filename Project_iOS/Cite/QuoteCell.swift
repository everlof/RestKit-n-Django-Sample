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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.textAlignment = .Center
        quoteLabel.text = "-"
        
        contentView.addSubview(quoteLabel)
        
        NSLayoutConstraint(item: quoteLabel, attribute: .Left, relatedBy: .Equal, toItem: self.contentView, attribute: .Left, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: quoteLabel, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier: 1.0, constant: 9.0).active = true
        NSLayoutConstraint(item: quoteLabel, attribute: .Right, relatedBy: .Equal, toItem: self.contentView, attribute: .Right, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: quoteLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1.0, constant: -9.0).active = true
    }

    func configureFor(q: Quote) -> UITableViewCell {
        let quote = q.quote ?? "-"
        quoteLabel.text = "\"\(quote)\""
        return self
    }
}