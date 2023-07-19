//
//  FilmCell.swift
//  RxSwift+MVVM
//
//  Created by Nguyen Anh  Tuan on 19/07/2023.
//

import UIKit

final class FilmCell: UITableViewCell {
    
    @IBOutlet private weak var filmBanner: UIImageView!
    @IBOutlet private weak var mainTitleFilm: UILabel!
    @IBOutlet private weak var subTitleFilm: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupView() {
        
    }
    
}
