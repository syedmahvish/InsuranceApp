import UIKit
import Generics

class QuoteRequestBillView: UIView {
    private lazy var amountLabel : UILabel = {
       let amountLabel = UILabel()
        amountLabel.textColor = .black
        amountLabel.font = UIFont.boldSystemFont(ofSize: 17)
        amountLabel.textAlignment = .center
        return amountLabel
    }()
    private lazy var amountSubTextLabel : UILabel = {
       let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    private lazy var topBorderView : UIView = {
        let view = UIView()
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    private lazy var bottomBorderView : UIView = {
        let view = UIView()
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    private lazy var categoryLabel : UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    private lazy var categoryTypeLabel : UILabel = {
       let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private lazy var messageLabel : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    private lazy var vStack : UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.alignment = .fill
        return vStack
    }()
    private lazy var hStack : UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fillProportionally
        hStack.alignment = .fill
        return hStack
    }()
    private var quoteBillPaymentViewModel : QuoteRequestBillViewConfigurable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        backgroundColor = .systemGray6
        hStack.addArrangedSubview(categoryLabel)
        hStack.addArrangedSubview(categoryTypeLabel)
        vStack.addArrangedSubview(amountLabel)
        vStack.addArrangedSubview(amountSubTextLabel)
        vStack.addArrangedSubview(topBorderView)
        vStack.addArrangedSubview(hStack)
        vStack.addArrangedSubview(bottomBorderView)
        vStack.addArrangedSubview(messageLabel)
        vStack.spacing = 5
        addSubview(vStack)
    }
    
    private func setConstraints() {
        topBorderView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        bottomBorderView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    func configureView(with billViewModel : QuoteRequestBillViewConfigurable) {
        guard let viewModel = billViewModel.quoteBillPaymentModel else {
            return
        }
        amountLabel.text = viewModel.amount
        amountSubTextLabel.text = viewModel.amountSubText
        categoryLabel.text = viewModel.categoryTypeText
        categoryTypeLabel.text = viewModel.categoryType
        messageLabel.text = viewModel.message
    }
}

protocol QuoteRequestBillViewConfigurable {
    var quoteBillPaymentModel : QuoteBillPaymentModel? {get}
}

class QuoteRequestBillViewViewModel : QuoteRequestBillViewConfigurable {
    var quoteBillPaymentModel : QuoteBillPaymentModel?
    
    init(quoteBillPaymentModel : QuoteBillPaymentModel) {
        self.quoteBillPaymentModel = quoteBillPaymentModel
    }
}
