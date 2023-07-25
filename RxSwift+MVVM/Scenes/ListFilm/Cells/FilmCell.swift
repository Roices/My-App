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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.filmBanner.image = nil
    }
    
    private func setupView() {
        viewRate.setRadius(4)
        viewRate.backgroundColor = UIColor(hexString: AppColor.Primary.main.rawValue)
        filmBanner.setRadius(8)
        
        lableRate.textColor = UIColor(hexString: AppColor.TextColor.main.rawValue)
        lableRate.textAlignment = .center
        self.backgroundColor = .clear
        mainTitleFilm.textColor = UIColor(hexString: AppColor.TextColor.main.rawValue)
        subTitleFilm.textColor = UIColor(hexString: AppColor.TextColor.main.rawValue)
        filmBanner.contentMode = .scaleAspectFill
        mainTitleFilm.numberOfLines = 0
    }
    
    public func bindData(filmModel: ResultFilm) {
        lableRate.text = (filmModel.voteAverage).toString()
        let urlBanner = String(format: "https://image.tmdb.org/t/p/original%@", filmModel.posterPath)
        filmBanner.setImage(with: URL(string: urlBanner))
        mainTitleFilm.text = filmModel.title
        subTitleFilm.text = filmModel.releaseDate
    }
    
    
}
