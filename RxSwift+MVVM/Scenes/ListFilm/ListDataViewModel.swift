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
    let isLoading: Observable<Bool>
    
    var errMessage: Observable<Error> {
        return self.error.asObserver()
    }
    
    var result: Observable<[Result]>
    let selectedFilm = BehaviorRelay<Result?>(value: nil)

    init(title: String){
        self.navigationBarTitle = Observable.just(title)
        self.isLoading = Observable.just(false)
//        loadmoreData()
        self.result = APIService.fetchData(1)
        
        _ = self.searchTrigger.subscribe(onNext: { data in
            print(data)
        })
        
        _ = self.loadmore.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.page  += 1
            self.result = APIService.fetchData(page)
        })
    }
    
    func loadmoreData() {
         _ = APIService.fetchData(self.page).subscribe(onNext: { [weak self] result in
            guard let self = self else { return }
//            self.result.append(contentsOf: result)
        }, onError: { [weak self] error in
            self?.error.onNext(error)
        })
    }
}

enum APIError: Error {
    case invalidData
}

class APIService {

    static func fetchData(_ page: Int) -> Observable<[Result]> {
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
