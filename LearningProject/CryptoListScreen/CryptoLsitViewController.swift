import UIKit
import SnapKit

class CryptoListViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var currentMode: ScreenMode = .defaultMode
    var isFavorite = false
  
    var presenter: CryptoListPresenter?
    var currencies = [CurrencyData]() {
        didSet {
            filteredCurrencies = currencies
        }
    }
    var filteredCurrencies = [CurrencyData]() {
        didSet {
            cryptoTable.reloadData()
        }
    }
    
    lazy var sortingButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "arrow.up.arrow.down.circle"), for: .normal)
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(favoritesButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var cryptoTable: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setConstraints()
        searchView()
    }
    
    func searchView() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setUpViews() {
        switch currentMode {
        case .defaultMode:
            view.addSubview(sortingButton)
            view.addSubview(favoritesButton)
            view.addSubview(cryptoTable)
        case .favoritesMode:
            view.addSubview(sortingButton)
            view.addSubview(cryptoTable)
        }
        
        presenter?.getCurrency(completion: { data in
            print(data)
        })
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        cryptoTable.register(CryptoTableViewCell.self, forCellReuseIdentifier: "CryptoTableViewCell")
        cryptoTable.delegate = self
        cryptoTable.dataSource = self
    }
    
    func setConstraints() {
        sortingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.trailing.equalTo(favoritesButton.snp.leading).inset(-5)
            make.height.equalTo(40)
        }
        
        favoritesButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        cryptoTable.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(sortingButton.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    func isFavoritesMode() -> Bool {
        return isFavorite
    }
    
    @objc func sortButtonTapped() {
        presenter?.sortCurrenciesByMarketCap()
    }
    
    @objc func favoritesButtonClick() {
        isFavorite.toggle()
        cryptoTable.reloadData()
    }
}

extension CryptoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFavorite {
            let favoriteCurrencies = FavoritesManager.shared.loadFavoriteCurrencies()
            return filteredCurrencies.filter { currency in
                favoriteCurrencies.contains { $0.id == currency.id }
            }.count
        } else {
            return filteredCurrencies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoTableViewCell", for: indexPath) as! CryptoTableViewCell
        let currency = filteredCurrencies[indexPath.row]
        cell.delegate = self
        cell.isFavorite = isFavorite
        cell.configure(with: currency)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency = filteredCurrencies[indexPath.row]

        let cryptoDetailViewController = CryptoDetailViewController()
        cryptoDetailViewController.currency = selectedCurrency

        navigationController?.pushViewController(cryptoDetailViewController, animated: true)
    }
}

extension CryptoListViewController: CryptoListView {
    func loadFilteredCurrencies(currencies: [CurrencyData]) {
        self.filteredCurrencies = currencies
    }
    
    func loadCurrencies(currencies: [CurrencyData]) {
        self.currencies = currencies
        self.cryptoTable.reloadData()
    }
}

extension CryptoListViewController: CryptoTableViewCellDelegate {
    func cryptoCell(_ cell: CryptoTableViewCell, didToggleFavorite isFavorite: Bool) {
        if let indexPath = cryptoTable.indexPath(for: cell) {
            var currency = filteredCurrencies[indexPath.row]
            currency.isFavorite = isFavorite
            presenter?.favoritesCurrencies(selectedCurrency: currency)
        }
    }
}

extension CryptoListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            let filteredCurrencies = currencies.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            presenter?.filterCurrencies(name: searchText, currencies: filteredCurrencies)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.filterCurrencies(name: "", currencies: currencies)
    }
}

enum ScreenMode {
    case defaultMode
    case favoritesMode
}
