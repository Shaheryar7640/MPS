//
//  ViewController.swift
//  MPS
//
//  Created by Shaheryar Malik on 29/07/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func moveToEditScreen(){
        let module = ImageFiltersBuilder().build(with: nil)
        let homeVC = UINavigationController()
        let item1 = module
        homeVC.setViewControllers([item1], animated: false)
        
        let foregroundedScenes = UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }
           let window = foregroundedScenes.map { $0 as? UIWindowScene }.compactMap { $0 }.first?.windows.filter { $0.isKeyWindow }.first
           
           guard let uWindow = window else { return }
           uWindow.rootViewController = homeVC
        UIView.transition(with: uWindow, duration: 0.7, options: [.transitionCrossDissolve], animations: {}, completion: nil)
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveToEditScreen()
    }
}





