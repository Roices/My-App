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
    
    let viewModel: ListDataViewModel = ListDataViewModel(title: "RxTest")
    let activity: UIActivityIndicatorView = {
       let indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0,
                                                                 width: UIScreen.main.bounds.width,
                                                                 height: UIScreen.main.bounds.height))
        indicatorView.stopAnimating()
         return indicatorView
    }()

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        self.view.addSubview(activity)
        // Do any additional setup after loading the view.
    }
    
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
    
    
    func showAlert(_ mess: String) {
        let alert = UIAlertController(title: "Alert", message: mess, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}


protocol StoryboardInstantiable: UIViewController {}

extension StoryboardInstantiable {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: className, bundle: nil)
        return storyboard.instantiateInitialViewController() as! Self
    }

    static func instantiateWithNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: className, bundle: nil)
        return storyboard.instantiateInitialViewController() as! UINavigationController
    }
}

extension NSObject {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        return type(of: self).className
    }
}
