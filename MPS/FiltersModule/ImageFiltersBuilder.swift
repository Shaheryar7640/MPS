//  
//  ImageFiltersBuilder.swift
//  MPS
//
//  Created by Shaheryar Malik on 29/07/2023.
//

import Foundation
import UIKit

class ImageFiltersBuilder {

    func build(with navigationController: UINavigationController?) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "ImageFilters", bundle: Bundle(for: ImageFiltersBuilder.self))
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImageFiltersViewController") as! ImageFiltersViewController
        let coordinator = ImageFiltersRouter(navigationController: navigationController)
        let viewModel = ImageFiltersViewModelImpl(router: coordinator)

        viewController.viewModel = viewModel
        
        return viewController
    }
}


