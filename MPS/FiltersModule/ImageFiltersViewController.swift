//  
//  ImageFiltersViewController.swift
//  MPS
//
//  Created by Shaheryar Malik on 29/07/2023.
//

import UIKit
import GPUImage

public class ImageFiltersViewController: UIViewController {
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var filtersCollectionView:UICollectionView!
    
    var viewModel: ImageFiltersViewModel!
    let categoryHeaderId = "categoryHeaderId"
    let headerId = "headerId"
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        bindViewModel()
        viewModel.viewModelDidLoad()
        let cancelButton = UIBarButtonItem(title:"Cancel", style: .plain, target: self, action: #selector(didTapCancelButton))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(title:"Save", style: .done, target: self, action: #selector(didTapSaveButton))
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    
    
    @objc func didTapCancelButton(){
    }
    
    @objc func didTapSaveButton(){
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewModelWillAppear()
    }
    
    
    
    
    @IBAction func didTapFilterCollectionButton(_ sender:UIButton){
        viewModel.didTapFilterCollectionButton(for: sender.tag)
    }
    
    fileprivate func bindViewModel() {
        
        viewModel.output = { [unowned self] output in
            //handle all your bindings here
            switch output {
            case .reloadFiltersCollection:
                self.filtersCollectionView.reloadData()
            }
        }
    }
    
    
    
}

extension ImageFiltersViewController {
    func configureAppearance() {
        self.filtersCollectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: Bundle(for: FilterCollectionViewCell.self)), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        filtersCollectionView.register(FilterCategoryHeaderView.self, forSupplementaryViewOfKind: categoryHeaderId, withReuseIdentifier: headerId)
        filtersCollectionView.collectionViewLayout = createCompositionalLayout()
        filtersCollectionView.reloadData()
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layouts = UICollectionViewCompositionalLayout.init { sectionIndex, environment in
            self.horizontalSection()
        }
        return layouts
    }
    
    private func horizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension: .fractionalWidth(0.25))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 12, trailing: 12)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)), elementKind: categoryHeaderId, alignment: .top)
        ]
        return section
    }
    
}

extension ImageFiltersViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfFilters(in: section)
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with:FilterCollectionViewCell.self, for: indexPath)
        cell.configure(with: viewModel.item(at: indexPath)) { filteredImage in
            self.imageView.image = filteredImage
        }
        return cell
        
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! FilterCategoryHeaderView
        header.label.text = viewModel.headerTitleFor(section: indexPath.section)
        return header
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectFilter(at: indexPath)
    }
}


