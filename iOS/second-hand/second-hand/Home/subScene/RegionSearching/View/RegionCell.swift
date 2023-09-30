//
//  RegionCell.swift
//  second-hand
//
//  Created by SONG on 2023/08/30.
//

import UIKit

class RegionCell: UITableViewCell {
    static let reuseIdentifier = "REGIONCELL"
    let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

extension RegionCell {
    func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
}


