import UIKit
import SnapKit

class CryptoTableViewCell: UITableViewCell {
    
    weak var delegate: CryptoTableViewCellDelegate?
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        return button
    }()

    var isFavorite = false
    
    @objc func favoritesButtonTapped() {
           isFavorite.toggle()
           delegate?.cryptoCell(self, didToggleFavorite: isFavorite)
       }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(favoritesButton)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        favoritesButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with currency: CurrencyData) {
        nameLabel.text = currency.name
        if let isFavorite = currency.isFavorite {
            let starImageName = isFavorite ? "star.fill" : "star"
            favoritesButton.setImage(UIImage(systemName: starImageName), for: .normal)
        } else {
            favoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
