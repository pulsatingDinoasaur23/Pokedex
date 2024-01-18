//
//  HomeModulePresenter.swift
//  Pokedex
//
//  Created by michaell medina on 17/01/24.
//

import Foundation

class HomeModulePresenter: HomeModulePresenterProtocol {
    var view: HomeModuleViewProtocol?
    var interactorInput: HomeModuleInteractorInputProtocol?
    var router: HomeModuleRouterProtocol?
    
    func viewDidLoad() {
        interactorInput?.fetchPokemonLists()
        let timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(fetchPokemonListsWithTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    @objc func fetchPokemonListsWithTimer() {
        interactorInput?.fetchPokemonLists()
    }
}
extension HomeModulePresenter: HomeModulePresenterInputProtocol {
    func showAnotherPokemon() {
        interactorInput?.fetchPokemonLists()
    }
}
extension HomeModulePresenter: HomeModulePresenterOutputProtocol {
    func presentViewOfPokemonS(_ imageDataArray: [PokemonCardDetails]) {
        view?.LoadImagesDetail(imageDataArray)
    }
}
