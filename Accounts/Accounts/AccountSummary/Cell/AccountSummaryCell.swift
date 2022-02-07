//
//  AccountSummaryCall.swift
//  Accounts
//
//  Created by Ben Garrison on 2/6/22.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    let accountTypeLabel = UILabel()
    let underlineView = UIView()
    let accountNameLabel = UILabel()
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    let arrow = UIImageView()
    
    static let reuseIdentifier = "AccountSummaryCell"
    static let rowHeight: CGFloat = 110
    
    enum AccountType: String {
        case Banking
        case Credit
        case Investment
    }
    
    struct AccountViewModel {
        let accountType: AccountType
        let accountName: String
    }
    
    let accountViewModel:AccountViewModel? = nil
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    setup()
    layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Layout/Setup
extension AccountSummaryCell {
    
    private func layout() {
        NSLayoutConstraint.activate([
            accountTypeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            accountTypeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: accountTypeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.widthAnchor.constraint(equalToConstant: 80),
            underlineView.heightAnchor.constraint(equalToConstant: 2),
            
            accountNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            accountNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalTo: accountNameLabel.trailingAnchor, constant: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            
            arrow.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: arrow.trailingAnchor, multiplier: 1)
            
        ])
    }
    
    private func setup() {
        accountTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        accountTypeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        accountTypeLabel.text = "Account Type"
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = applicationColor
        
        accountNameLabel.translatesAutoresizingMaskIntoConstraints = false
        accountNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        accountNameLabel.text = "Account Name"
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.text = "Balance"
        
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "999", cents: "99")
        
        arrow.translatesAutoresizingMaskIntoConstraints = false
        let arrowImage = UIImage(systemName: "chevron.right")!.withTintColor(applicationColor, renderingMode: .alwaysOriginal)
        arrow.image = arrowImage
    
        contentView.addSubview(accountTypeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(accountNameLabel)
        
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        contentView.addSubview(balanceStackView)
        
        contentView.addSubview(arrow)
    }

}

//MARK: Font Styling
extension AccountSummaryCell {
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}

//MARK: View Model Configuration
extension AccountSummaryCell {
    func configure(with avm: AccountViewModel) {
        accountTypeLabel.text = avm.accountType.rawValue
        accountNameLabel.text = avm.accountName
        switch avm.accountType {
        case .Banking:
            underlineView.backgroundColor = .systemOrange
        case .Credit:
            underlineView.backgroundColor = .systemMint
        case .Investment:
            underlineView.backgroundColor = .systemPink
        }
    }
}
