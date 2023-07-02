import UIKit

class AmountView: UIView {
    
    private let title: String
    private let textAligment: NSTextAlignment
    
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
    
    init(title: String, textAligment: NSTextAlignment) {
        self.title = title
        self.textAligment = textAligment
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() -> Void {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

