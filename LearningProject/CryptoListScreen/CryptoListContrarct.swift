import Foundation

protocol CryptoListView: AnyObject {
    func loadCurrencies(currencies: [CurrencyData])
    func loadFilteredCurrencies(currencies: [CurrencyData])
}

protocol CryptoListPresentation: AnyObject {
    func getCurrency(completion: @escaping ([CurrencyData]) -> ())
    func filterCurrencies(name: String, currencies: [CurrencyData])
    func sortCurrenciesByMarketCap()
    func favoritesCurrencies(selectedCurrency: CurrencyData)
}

protocol CryptoTableViewCellDelegate: AnyObject {
    func cryptoCell(_ cell: CryptoTableViewCell, didToggleFavorite isFavorite: Bool)
}
