//
//  GFButton.swift
//  GHFollowers
//
//  Created by Daniel Freire on 2/14/24.
//

import UIKit

class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        set(color: color, title: title, systemImageName: systemImageName)
    }

    private func configure() {
        configuration = .filled()
        configuration?.baseForegroundColor = .white
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }

    func set(color: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor = color
        configuration?.title = title

        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }
}
