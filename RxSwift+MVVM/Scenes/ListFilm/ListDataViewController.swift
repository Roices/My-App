//
//  ListDataViewController.swift
//  RxSwift+MVVM
//
//  Created by Nguyen Anh  Tuan on 24/05/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ListDataViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var navBarView: NavBarHome!
    @IBOutlet private weak var nowInCinemasTitle: UILabel!
    @IBOutlet private weak var collectionViewFilm: UICollectionView!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var textFieldSearch: UITextField!
    @IBOutlet private weak var buttonSearch: UIButton!
    
    // MARK: - Properties
    let viewModel: ListDataViewModel = ListDataViewModel(title: "RxTest")
    private let disposeBag = DisposeBag()
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        setupRxTap()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    func bindViewModel() {
        viewModel.navigationBarTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
//        viewModel.result
//            .bind(to: tableDataRx.rx.items) { tableView, row, dataRes in
//                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitle")
//                cell.textLabel?.text = dataRes.title
//                return cell
//            }.disposed(by: disposeBag)
        
        viewModel.errMessage.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] err in
                self?.showAlert(err.localizedDescription)
            }).disposed(by: disposeBag)
        
        viewModel.result.bind(to: collectionViewFilm.rx.items(cellIdentifier: "FilmCell", cellType: FilmCell.self)) { index, model, cell in
            cell.bindData(filmModel: model)
            return
        }.disposed(by: disposeBag)
        
        let layout = Observable.just(UICollectionViewFlowLayout())
                // Sử dụng toán tử map để cung cấp mô tả layout cho UICollectionView
                layout
                    .map { layout -> UICollectionViewLayout in
                        layout.itemSize = CGSize(width: (self.collectionViewFilm.width-16*2)/2 , height: 278)
                        layout.minimumInteritemSpacing = 16
                        layout.minimumLineSpacing = 16
                        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
                        return layout
                    }
                    .bind(to: collectionViewFilm.rx.collectionViewLayout)
                    .disposed(by: disposeBag)
        
//        collectionViewFilm.rx.willDisplayCell.subscribe { (cell, indexPath) in
//            self.handleCellWillDisplay(at: indexPath, cell: cell)
//        }.disposed(by: disposeBag)
//        let _ = searchButton.rx.tap.subscribe { [weak self] _ in
//            guard let searchData = self?.textfieldSearch.text else { return }
//            self?.viewModel.searchTrigger.onNext(searchData)
//        }
//
//        tableDataRx.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
//        }).disposed(by: disposeBag)
//
//        tableDataRx.rx.contentOffset
//            .skip(1) // Bỏ qua sự kiện offset đầu tiên khi view load
//            .map { [weak self] contentOffset in
//                return self?.shouldLoadMoreData(contentOffset) ?? false
//            }
//            .distinctUntilChanged()
//            .filter { $0 }
//            .subscribe(onNext: { [weak self] _ in
//                self?.viewModel.loadmore.onNext(())
//            })
//            .disposed(by: disposeBag)
//
        
    }
    
//    private func shouldLoadMoreData(_ contentOffset: CGPoint) -> Bool {
//        let tableViewHeight = tableDataRx.frame.height
//        let contentHeight = tableDataRx.contentSize.height
//        let offsetThreshold = contentHeight - tableViewHeight
//
//        return contentOffset.y > offsetThreshold
//    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(hexString: AppColor.Surface.main.rawValue)
        self.nowInCinemasTitle.text = "Now in cinemas"
        self.nowInCinemasTitle.textColor = UIColor(hexString: AppColor.TextColor.main.rawValue)
        self.textFieldSearch.isHidden = true
        self.textFieldSearch.textColor = UIColor(hexString: AppColor.TextColor.main.rawValue)
        self.hideKeyboardWhenTappedAround()
        self.setupForKeyboard()
        self.collectionViewFilm.register(UINib(nibName: "FilmCell", bundle: nil), forCellWithReuseIdentifier: "FilmCell")
    }
    
    private func setupRxTap() {
        self.buttonSearch.rx.tap.bind { [weak self] in
            self?.handleSearchButtonTapp()
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Action
    private func handleSearchButtonTapp() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.buttonSearch.isHidden = true
            self?.nowInCinemasTitle.isHidden = true
            self?.textFieldSearch.isHidden = false
            self?.textFieldSearch.placeholder = "Now in cinemas"
            self?.textFieldSearch.becomeFirstResponder()
        })
    }
    
    @objc override func keyboardWillDisappear() {
        //Do something here
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.buttonSearch.isHidden = false
            self?.nowInCinemasTitle.isHidden = false
            self?.textFieldSearch.isHidden = true
        })
    }
    
    //
    func showAlert(_ mess: String) {
        let alert = UIAlertController(title: "Alert", message: mess, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
