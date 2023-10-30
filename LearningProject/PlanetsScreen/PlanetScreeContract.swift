import Foundation

protocol PlanetsPresenter: AnyObject {
    func getPlanets()
    func setView(_ view: PlanetsView)
}

protocol PlanetsView: AnyObject {
    func setPlanets(_ planets: [Planet])
}
