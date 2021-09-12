//
//  MainTableViewHeaderView.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/06.
//

import UIKit

final class MainTableViewHeaderView: UITableViewHeaderFooterView {
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(categoryLabel)
        self.addSubview(sectionTitle)
        setBackgroundView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubview(categoryLabel)
        self.addSubview(sectionTitle)
        setBackgroundView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            categoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            sectionTitle.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            sectionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            sectionTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16)
        ])
    }
    
    private func setBackgroundView() {
        backgroundView = UIView(frame: frame)
        backgroundView?.backgroundColor = UIColor.white
        backgroundView?.alpha = 0.7
    }
    
    func configure(sectionModel: MainSection) {
        categoryLabel.text = sectionModel.category
        sectionTitle.text = sectionModel.header
    }
}

