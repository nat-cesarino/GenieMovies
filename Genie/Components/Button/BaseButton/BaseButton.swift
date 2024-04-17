//
//  BaseButton.swift
//  Genie
//
//  Created by Nathalie Cesarino on 11/04/23.
//

import UIKit
import RxSwift
import RxCocoa

public final class BaseButton: UIControl, SetupView {

    // =========================================================
    // MARK: - UI properties
    // =========================================================

    public private(set) lazy var iconImageView: UIImageView = buildIconImageView(icon: icon)
    public private(set) lazy var textLabel: UILabel = buildLabel()
    private lazy var stackView: UIStackView = buildStackView(icon: icon)

    // =========================================================
    // MARK: - Public properties
    // =========================================================

    public var tap: ControlEvent<Void> {
        return rx.controlEvent(.touchUpInside)
    }

    override public var isEnabled: Bool {
        didSet {
            currentState.onNext(isEnabled ? .normal : .disable)
        }
    }

    // =========================================================
    // MARK: - Private properties
    // =========================================================

    private let currentState = BehaviorSubject<BaseButton.State>(value: .normal)
    private let style: BaseButton.Style
    private let colorScheme: BaseButton.StyleColorScheme
    private let icon: BaseButton.Icon

    private let disposeBag = DisposeBag()

    // =========================================================
    // MARK: - Initializer
    // =========================================================

    public init(
        style: BaseButton.Style,
        colorScheme: BaseButton.StyleColorScheme = .default,
        icon: BaseButton.Icon = .none
    ) {
        self.style = style
        self.colorScheme = colorScheme
        self.icon = icon

        super.init(frame: .zero)

        buildSelf()
        setupUI()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // =========================================================
    // MARK: - SetupView methods
    // =========================================================

    public func bind() {
        rx.controlEvent(.touchDown)
            .asDriver().drive(onNext: { [weak self] in
                self?.currentState.onNext(.touched)
            }).disposed(by: disposeBag)

        rx.controlEvent([.touchUpInside, .touchUpOutside, .touchCancel])
            .asDriver().drive(onNext: { [weak self] in
                self?.currentState.onNext(.normal)
            }).disposed(by: disposeBag)

        currentState.subscribe(onNext: { [weak self] state in
            self?.renderForState(state)
        }).disposed(by: disposeBag)

        textLabel.rx.observe(String.self, "text").subscribe(onNext: { [weak self] text in
            guard let safeText = text else { return }
            self?.accessibilityLabel = safeText
        }).disposed(by: disposeBag)
    }

    public func buildViewHierarchy() {
        addSubview(stackView)
    }

    public func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(19)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(24)
            $0.trailing.lessThanOrEqualToSuperview().offset(-24)
        }
    }

    // =========================================================
    // MARK: - Build methods
    // =========================================================

    private func renderForState(_ state: BaseButton.State) {
        let styler = SofiaButtonStyle()
        let textAndIconColor = styler.colorForTextAndIcon(
            style: style, colorScheme: colorScheme, state: state
        )

        layer.borderColor = styler.colorForBorder(
            style: style, colorScheme: colorScheme, state: state
        ).cgColor

        backgroundColor = styler.colorForFill(
            style: style, colorScheme: colorScheme, state: state
        )

    //    textLabel.setTextColor(withCustomColor: textAndIconColor)
        textLabel.textColor = textAndIconColor
        iconImageView.tintColor = textAndIconColor
    }

    private func buildSelf() {
        translatesAutoresizingMaskIntoConstraints = false
        setContentCompressionResistancePriority(.required, for: .vertical)
        isAccessibilityElement = true
        accessibilityTraits = .button
        layer.borderWidth = 2
        layer.cornerRadius = 8
        layer.borderColor = UIColor.clear.cgColor
    }

    private func buildLabel() -> UILabel {
    //    let view = SofiaLabel(size: .xs, weight: .bold, lineHeight: .xs, colorTheme: .neutral100)
        let view = UILabel()
        view.textColor = UIColor(hex: "0xdee2e6ff") ?? .black
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    //    view.numberOfLines = 0
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.isUserInteractionEnabled = false
        view.isAccessibilityElement = false

        return view
    }

    private func buildIconImageView(icon: BaseButton.Icon) -> UIImageView {
        let view: UIImageView

        switch icon {
        case .none:
            return UIImageView(frame: .zero)
        case let .left(image):
            view = UIImageView(image: image)
        case let .right(image):
            view = UIImageView(image: image)
        }

        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.contentMode = .scaleAspectFit
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false

        return view
    }

    private func buildStackView(icon: BaseButton.Icon) -> UIStackView {
        let views: [UIView]

        switch icon {
        case .none:
            views = [textLabel]
        case .left:
            views = [iconImageView, textLabel]
        case .right:
            views = [textLabel, iconImageView]
        }

        let view = UIStackView(arrangedSubviews: views)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 10

        return view
    }
}

