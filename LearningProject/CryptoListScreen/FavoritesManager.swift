import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "FavoriteCurrencies"
    
    func saveFavoriteCurrencies(currencies: [CurrencyData]) {
        let encodedData = try? JSONEncoder().encode(currencies)
        userDefaults.set(encodedData, forKey: favoritesKey)
    }
    
    func loadFavoriteCurrencies() -> [CurrencyData] {
        if let encodedData = userDefaults.data(forKey: favoritesKey),
           let currencies = try? JSONDecoder().decode([CurrencyData].self, from: encodedData) {
            return currencies
        }
        return []
    }
}
