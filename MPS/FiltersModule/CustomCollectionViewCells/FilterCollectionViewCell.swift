//
//  FilterCollectionViewCell.swift
//  MPS
//
//  Created by Shaheryar Malik on 29/07/2023.
//

import UIKit
import GPUImage

public typealias filterCallBack = (PlatformImageType) -> ()

class FilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var renderView:RenderView!
    @IBOutlet weak var filterImageView:UIImageView!
    var callBack:filterCallBack!
    var filteredPlatFormImage :PlatformImageType!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
    }

    func configure(with operation:BasicOperation,callBack:@escaping filterCallBack){
        self.callBack = callBack
        filterImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        filterImageView.addGestureRecognizer(tap)
        filterImageView.layer.cornerRadius = 4
        filterImageView.clipsToBounds = true
        let filteredImage = UIImage(named:"testImg")!.filterWithOperation(operation)
        filterImageView.image = filteredImage
        filteredPlatFormImage = filteredImage
       
    }
    
    @objc func didTapImageView(){
        callBack(filteredPlatFormImage)
    }
}
