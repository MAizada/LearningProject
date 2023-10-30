import Alamofire
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let apiUrl = "https://swapi.dev/api/planets"
    let currencyAPi = "https://api.coincap.io/v2/assets"
    
    func getPlanets(completion: @escaping ([Planet]) -> ()) {
       AF.request(apiUrl).responseData { response in
           let jsonDecoder = JSONDecoder()
           switch response.result{
           case .success( let data ):
               do {
                   let planets = try jsonDecoder.decode(PlanetResult.self, from: data)
                   print(planets)
                   completion(planets.results)
               } catch {
                   print("error")
               }
           case .failure( let error ):
               print(error)
           }
        }
    }
    
    func getCurrencies(completion: @escaping ([CurrencyData]) -> ()) {
        AF.request(currencyAPi).responseData { response in
            let jsonDecoder = JSONDecoder()
            switch response.result{
            case .success( let data ):
                do {
                    let currencies = try jsonDecoder.decode(CryptoCurrency.self, from: data)
                    print(currencies)
                    completion(currencies.data)
                } catch {
                    print("Error decoding data")
                }
            case .failure( let error ):
                print("Request failed with error: \(error)")
            }
        }
    }
}
