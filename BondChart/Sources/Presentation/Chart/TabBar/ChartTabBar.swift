import UIKit

final class ChartTabBar: UIStackView {
    var onSelectTab: ((Int) -> Void)?

    var tabs: [String] = [] {
        didSet {
            cleanup()
            setup()
        }
    }

    private var buttons: [UIButton] = []

    @objc private func selectTab(_ sender: UIButton) {
        deselectAll()
        sender.isSelected = true
        if let idx = buttons.index(of: sender) {
            onSelectTab?(idx)
        }
    }
}

private extension ChartTabBar {
    func cleanup() {
        buttons.forEach { $0.removeFromSuperview() }
        buttons = []
    }

    func setup() {
        tabs.forEach {
            let bt = UIButton.chartTabBarButton(title: $0)
            bt.addTarget(self, action: #selector(selectTab(_:)), for: .touchUpInside)
            addArrangedSubview(bt)
            buttons.append(bt)
        }
        buttons.first?.isSelected = true
    }

    func deselectAll() {
        buttons.forEach { $0.isSelected = false }
    }
}

private extension UIButton {
    class func chartTabBarButton(title: String) -> UIButton {
        let bt = UIButton(frame: .zero)
        bt.setTitle(title, for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.setTitleColor(.blue, for: .selected)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return bt
    }
}
