//
//  PokedexApp.swift
//  Pokedex
//
//  Created by michaell medina on 17/01/24.
//

import SwiftUI

struct MyCustomViewControllerWrapper<RouterType: HomeModuleRouterProtocol>: UIViewControllerRepresentable {
    let router: RouterType
    init(router: RouterType) {
        self.router = router
    }
    func makeUIViewController(context: Context) -> UIViewController {
        guard let startView = router.view else {
            return UIViewController()
        }
        let navigationController = UINavigationController(rootViewController: startView)
        return navigationController
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
@main
struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            let homeModuleRouter = HomeModuleRouter()
            MyCustomViewControllerWrapper(router: homeModuleRouter)
        }
    }
}

