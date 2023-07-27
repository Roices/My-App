//
//  ListDataViewModel.swift
//  RxSwift+MVVM
//
//  Created by Nguyen Anh  Tuan on 24/05/2023.
//

import RxSwift
import RxCocoa
import UIKit


final class ListDataViewModel {
    
    let loadmore = PublishSubject<Void>()
    let searchTrigger = PublishSubject<String>()
    var error = PublishSubject<Error>()
    private var page: Int = 1
    
    let navigationBarTitle: Observable<String>
    var isLoading = false
    
    var resultLoadMore = BehaviorRelay<[ResultFilm]>(value: [])
    var result: Observable<[ResultFilm]>
    var resultSearch: Observable<[ResultFilm]>
    var isHasLoadPage0 = false
    let selectedFilm = BehaviorRelay<ResultFilm?>(value: nil)
    let disposeBag = DisposeBag()
    
    init(title: String){
        self.navigationBarTitle = Observable.just(title)
        self.result = self.resultLoadMore.asObservable()
        self.resultSearch = self.result
        
        _ = self.searchTrigger.subscribe(onNext: { data in
            print(data)
        })
        
        self.loadmoreData()
        
        _ = self.loadmore
            .filter { !self.isLoading }
            .subscribe(onNext: { _ in
            self.loadmoreData()
        }).disposed(by: disposeBag)
        
        searchTrigger.subscribe { textSearch in
            print(textSearch)
        }.disposed(by: disposeBag)
    }
    
    func loadmoreData() {
        _ = APIService.fetchData(page).subscribe(onNext: { [weak self] loadmoreData in
            if self?.page == 1 && !(self?.isHasLoadPage0 ?? true) {
                self?.resultLoadMore.accept(loadmoreData)
                self?.isHasLoadPage0 = true
            } else {
                var currentItems = self?.resultLoadMore.value ?? []
                currentItems.append(contentsOf: loadmoreData)
                self?.resultLoadMore.accept(currentItems)
            }
            self?.isLoading = false
            self?.page += 1
        }, onError: { [weak self] error in
            self?.error.onNext(error)
        })
    }
    
//    func searchFilterData(with keyword: String) -> Observable<[ResultFilm]> {
//        return Observable.create { [weak self] observable in
//
//        }
//    }
}

enum APIError: Error {
    case invalidData
}

class APIService {

    static func fetchData(_ page: Int) -> Observable<[ResultFilm]> {
        // Gọi API và trả về dữ liệu dưới dạng Observable
        // Ví dụ:
        return Observable.create { observable in
            let url = URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=f620c9bc859bc744841e2a7c8e2a27fa&page=\(page)")!
            print(url)
            let task = URLSession.shared.dataTask(with: url) { data, res, err in
                if let err = err {
                    observable.onError(err)
                    return
                }
                
                guard let data = data else {
                    observable.onError(APIError.invalidData)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MovieDB.self, from: data)
                    let result = response.results
                    observable.onNext(result)
                    observable.onCompleted()
                    print("===============LOG===============")
                    if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                       print(JSONString)
                    }
                } catch {
                    print(error)
                    observable.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
