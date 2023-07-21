//
//  FilmCell.swift
//  RxSwift+MVVM
//
//  Created by Nguyen Anh  Tuan on 19/07/2023.
//

import UIKit

final class FilmCell: UICollectionViewCell {
    
    @IBOutlet private weak var filmBanner: UIImageView!
    @IBOutlet private weak var mainTitleFilm: UILabel!
    @IBOutlet private weak var subTitleFilm: UILabel!
    @IBOutlet private weak var lableRate: UILabel!
    @IBOutlet private weak var viewRate: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    private func setupView() {
        viewRate.setRadius(4)
        viewRate.backgroundColor = UIColor(hexString: AppColor.Primary.main.rawValue)
        
        lableRate.textColor = UIColor(hexString: AppColor.TextColor.main.rawValue)
    }
    
    public func bindData(filmModel: ResultFilm) {
        lableRate.text = (filmModel.voteAverage).toString()
        filmBanner.downloadedFrom(link: filmModel.backdropPath)
        mainTitleFilm.text = filmModel.title
        subTitleFilm.text = filmModel.overview
    }
    
}
