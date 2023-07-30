//  
//  ImageFiltersViewModel.swift
//  MPS
//
//  Created by Shaheryar Malik on 29/07/2023.
//

import Foundation
import GPUImage

typealias ImageFiltersViewModelOutput = (ImageFiltersViewModelImpl.Output) -> Void

protocol ImageFiltersViewModelInput {
    func didTapFilterCollectionButton(for tag:Int)
    func numberOfFilters(in section:Int)->Int
    func numberOfSection()->Int
    func item(at indexPath:IndexPath)->BasicOperation
    func didSelectFilter(at indexPath:IndexPath)
    func headerTitleFor(section: Int)->String
}

protocol ImageFiltersViewModel: ImageFiltersViewModelInput {
    var output: ImageFiltersViewModelOutput? { get set}
    var filters:[[BasicOperation]] {get set}
    var selectedFilters:[BasicOperation] {get set}
    func viewModelDidLoad()
    func viewModelWillAppear()
}

class ImageFiltersViewModelImpl: ImageFiltersViewModel, ImageFiltersViewModelInput {
    
    private let router: ImageFiltersRouter
    var output: ImageFiltersViewModelOutput?
    var filters: [[BasicOperation]]
    var selectedFilters:[BasicOperation]
    init(router: ImageFiltersRouter) {
        self.router = router
        filters = []
        selectedFilters = []
        setFilters()
        selectedFilters = filters.first ?? []
    }
    
    func viewModelDidLoad() {
        
    }
    
    func viewModelWillAppear() {
        
    }
    
    //For all of your viewBindings
    enum Output {
        case reloadFiltersCollection
    }
   
    func setFilters(){
        filters = [[MonochromeFilter(),ToonFilter(),SketchFilter(),SepiaToneFilter(),ColorMatrixFilter()],[HueAdjustment(),SepiaToneFilter(),FalseColor(),SepiaToneFilter(),Haze()],[MonochromeFilter(),ToonFilter(),SketchFilter(),SepiaToneFilter(),ColorMatrixFilter()],[Crosshatch(),LuminanceRangeReduction(),SketchFilter(),HueAdjustment(),HueAdjustment()],[SepiaToneFilter(),SepiaToneFilter(),MonochromeFilter(),FalseColor(),HueAdjustment()]]
    }
}

extension ImageFiltersViewModelImpl {
    
    func headerTitleFor(section: Int)->String {
        return "Filters"
    }
    func didTapFilterCollectionButton(for tag: Int) {
        setFilters()
        selectedFilters = filters[tag]
        output?(.reloadFiltersCollection)
    }
    
    func numberOfFilters(in section: Int)->Int {
        return selectedFilters.count
    }
    func item(at indexPath: IndexPath) -> BasicOperation {
        return selectedFilters[indexPath.item]
    }
    func numberOfSection()->Int {
        return 1
    }
    
    func didSelectFilter(at indexPath: IndexPath) {
    }
}
