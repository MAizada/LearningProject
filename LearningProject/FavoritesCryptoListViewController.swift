//
//import UIKit
//import SnapKit
//
//class FavoritesCryptoListViewController: UIViewController {
//    
//    var presenter: CryptoListPresenter?
//    var currencies = [CurrencyData]() {
//        didSet {
//            filteredCurrencies = currencies
//        }
//    }
//    
//    var filteredCurrencies = [CurrencyData]() {
//        didSet {
//            cryptoTable.reloadData()
//        }
//    }
//    
//    lazy var searchBar: UITextField = {
//        let textField = UITextField()
//        textField.borderStyle = .roundedRect
//        textField.placeholder = "insert text"
//        return textField
//    }()
//    
//    lazy var searchButton: UIButton = {
//        let button = UIButton()
//        button.layer.cornerRadius = 10
//        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    lazy var sortingButton: UIButton = {
//        let button = UIButton()
//        button.layer.cornerRadius = 10
//        button.setImage(UIImage(systemName: "arrow.up.arrow.down.circle"), for: .normal)
//        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    lazy var cryptoTable: UITableView = {
//        let tableView = UITableView()
//        return tableView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUpViews()
//        setConstraints()
//        setUpNavigationBar()
//    }
//    
//    func setUpViews() {
//        presenter?.getCurrency(completion: { data in
//            print(data)
//        })
//        view.backgroundColor = .white
//        navigationController?.navigationBar.isHidden = false
//        cryptoTable.register(CryptoTableViewCell.self, forCellReuseIdentifier: "CryptoTableViewCell")
//        cryptoTable.delegate = self
//        cryptoTable.dataSource = self
//        view.addSubview(searchBar)
//        view.addSubview(searchButton)
//        view.addSubview(sortingButton)
//        view.addSubview(cryptoTable)
//    }
//    
//    func setConstraints() {
//        searchBar.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(100)
//            make.leading.equalToSuperview().inset(16)
//            make.height.equalTo(40)
//            make.trailing.equalTo(searchButton.snp.leading).offset(-10)
//        }
//        searchButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(100)
//            make.trailing.equalTo(sortingButton.snp.leading).inset(-5)
//            make.height.equalTo(40)
//        }
//        
//        sortingButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(100)
//            make.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(40)
//        }
//        
//        cryptoTable.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(16)
//            make.top.equalTo(searchBar.snp.bottom).offset(10)
//            make.bottom.equalToSuperview()
//        }
//    }
//    
//    func setUpNavigationBar() {
//           let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
//           navigationItem.leftBarButtonItem = backButton
//       }
//    
//    @objc func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    
//    @objc func buttonTapped() {
//        presenter?.filterCurrencies(name: searchBar.text!, currencies: currencies)
//    }
//    
//    @objc func sortButtonTapped() {
//        presenter?.sortCurrenciesByMarketCap()
//    }
//}
//
//extension FavoritesCryptoListViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        filteredCurrencies.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoTableViewCell", for: indexPath) as! CryptoTableViewCell
//        let currency = filteredCurrencies[indexPath.row]
//        cell.configure(with: currency)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedCurrency = filteredCurrencies[indexPath.row]
//    }
//}
//
//extension FavoritesCryptoListViewController: CryptoListView {
//    func loadFilteredCurrencies(currencies: [CurrencyData]) {
//        self.filteredCurrencies = currencies
//    }
//    
//    func loadCurrencies(currencies: [CurrencyData]) {
//        self.currencies = currencies
//        self.cryptoTable.reloadData()
//    }
//}
//
//
//
