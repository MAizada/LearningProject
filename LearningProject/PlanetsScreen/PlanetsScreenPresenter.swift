import Foundation

class PlanetsScreenPresenter: PlanetsPresenter {
    
    let manager = NetworkManager.shared
    weak var view: PlanetsView?
    
    func getPlanets() {
        manager.getPlanets { planets in
            print(planets)
            self.view?.setPlanets(planets)
        }
    }
    
    func setView(_ view: PlanetsView) {
        self.view = view
    }

}
