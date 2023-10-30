import UIKit
import Alamofire
import Kingfisher
import SnapKit


class PlanetsScreenViewController: UIViewController{    
    var count: Int = 0
    var planets = [Planet]() {
        didSet {
//            tableView.reloadData()
        }
    }
    var presenter: PlanetsPresenter?
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "some text"
        label.textColor = .black
        return label
    }()

    lazy var  label : UIButton = {
        let label = UIButton()
        label.setTitle("Tap me", for: .normal)
        label.setTitleColor(.black, for: .normal)
        label.addTarget(self, action: #selector(labelDidTapped), for: .touchUpInside)
        return label
    }()
    
    
    let myImage: CustomImageView = {
       let image = CustomImageView()
        image.imageName = "globe"
        return image
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        presenter?.getPlanets()
    }
    
    func setup(){
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.height.width.equalTo(100)
        }
        
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.bottom.equalTo(label.snp.top).offset(-8)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
        
    @objc func labelDidTapped() {
        myImage.imageName = "location"
    }
}

extension PlanetsScreenViewController: PlanetsView {
    func setPlanets(_ planets: [Planet]) {
        self.planets = planets
        print(planets)
    }
}

