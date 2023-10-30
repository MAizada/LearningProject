import UIKit

protocol ChangeText {
    func changeText()
}

class CustomImageView: UIView {
    var delegate: ChangeText?
    
    var imageName = "heart" {
        didSet {
            delegate?.changeText()
        }
    }
    lazy var  image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image")
        return image
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = .red
        self.addSubview(image)
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
