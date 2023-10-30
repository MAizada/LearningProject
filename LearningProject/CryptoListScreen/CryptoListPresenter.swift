import UIKit

class CryptoListPresenter: CryptoListPresentation {
    
    var view: CryptoListView?
    var currencies = [CurrencyData]()
    var originalCurrencies = [CurrencyData]()
    var isSortingAscending = true
    
    func getCurrency(completion: @escaping ([CurrencyData]) -> ()) {
        NetworkManager.shared.getCurrencies { currencies in
            self.originalCurrencies = currencies
            self.currencies = currencies
            self.view?.loadCurrencies(currencies: currencies)
        }
    }
    
    func filterCurrencies(name: String, currencies: [CurrencyData]) {
        var filteredCurrencies = [CurrencyData]()
        filteredCurrencies = currencies.filter({ $0.name.contains(name) })
        view?.loadFilteredCurrencies(currencies: filteredCurrencies)
    }
    
    func sortCurrenciesByMarketCap() {
        if isSortingAscending {
            currencies = originalCurrencies.sorted { $0.marketCapUsd < $1.marketCapUsd }
        } else {
            currencies = originalCurrencies.sorted { $0.marketCapUsd > $1.marketCapUsd }
        }
        view?.loadCurrencies(currencies: currencies)
        isSortingAscending.toggle()
    }

    func favoritesCurrencies(selectedCurrency: CurrencyData) {
        var favoriteCurrencies = FavoritesManager.shared.loadFavoriteCurrencies()
        if let index = favoriteCurrencies.firstIndex(where: { $0.id == selectedCurrency.id }) {
            favoriteCurrencies.remove(at: index)
        } else {
            favoriteCurrencies.append(selectedCurrency)
        }
        FavoritesManager.shared.saveFavoriteCurrencies(currencies: favoriteCurrencies)
        view?.loadCurrencies(currencies: currencies)
    }
}
