import UIKit

class AmountView: UIView {
    
    private let title: String
    private let textAligment: NSTextAlignment
    private let amountLabelIdentifier: String
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(
            text: title,
            font: ThemeFont.regular(ofSize: 18),
            textColor: ThemeColot.text,
            textAligment: textAligment)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAligment
        label.textColor = ThemeColot.primary
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [
                .font: ThemeFont.bold(ofSize: 24)
            ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 16)
        ], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.accessibilityIdentifier = amountLabelIdentifier
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        titleLabel,
        amountLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    init(title: String, textAligment: NSTextAlignment, amountLabelIdentifier: String) {
        self.title = title
        self.textAligment = textAligment
        self.amountLabelIdentifier = amountLabelIdentifier
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(amount: Double) {
        let text = NSMutableAttributedString(
            string: amount.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes(
            [.font: ThemeFont.bold(ofSize: 16)],
            range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }
    
    private func layout() -> Void {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

