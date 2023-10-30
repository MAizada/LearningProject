import UIKit

class CryptoDetailViewController: UIViewController {
    
    var currency: CurrencyData?
    var currencyData: [String] = []
    
    lazy var detailTable: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        setUpViews()
        setConstraints()
        setUpNavigationBar()
    }
    
    func setUpViews() {
        if let currency = currency {
            currencyData.append("Name: \(currency.name)")
            currencyData.append("Id: \(currency.id)")
            currencyData.append("Rank: \(currency.rank)")
            currencyData.append("Symbol: \(currency.symbol)")
            currencyData.append("Supply: \(currency.supply)")
            currencyData.append("Max Supply: \(currency.maxSupply)")
            currencyData.append("Market Cap Usd: \(currency.marketCapUsd)")
            currencyData.append("Volume Usd 24Hr: \(currency.volumeUsd24Hr)")
            currencyData.append("Price Usd: \(currency.priceUsd)")
            currencyData.append("Change Percent 24Hr: \(currency.changePercent24Hr)")
            currencyData.append("Vwap 24Hr: \(currency.vwap24Hr)")
            currencyData.append("Explorer: \(currency.explorer)")
            
            detailTable.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailTableViewCell")
            detailTable.delegate = self
            detailTable.dataSource = self
            view.addSubview(detailTable)
        }
    }
    
    func setConstraints() {
        detailTable.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(100)
            make.bottom.equalToSuperview()
        }
    }
    
    func setUpNavigationBar() {
           let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
           navigationItem.leftBarButtonItem = backButton
       }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension CryptoDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath)
        cell.textLabel?.text = currencyData[indexPath.row]
        return cell
    }
}
