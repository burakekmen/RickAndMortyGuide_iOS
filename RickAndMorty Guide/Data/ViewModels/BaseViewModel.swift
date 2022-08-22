//
//  BaseViewModel.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 16.05.2022.
//

import ReactiveKit
import Bond

typealias ErrorStateSubject = PassthroughSubject<ErrorState, Never>
typealias ScreenStateSubject<T> = PassthroughSubject<T, Never>

// protocol IBaseViewModel { }

class BaseViewModel {

    deinit {
        print("killed: \(type(of: self))")
    }

    internal let disposeBag = DisposeBag()

    func handleResourceToAPIState<CONTENT: Codable, RESPONSE: Codable>(
        errorState: ErrorStateSubject?,
        response: Observable<RESPONSE?>,
        request: Signal<Resource<CONTENT>, Never>,
        callbackLoading: ((Bool) -> Void)? = nil,
        callbackSuccess: (() -> Void)? = nil,
        callbackComplete: (() -> Void)? = nil,
        callbackEmpty: (() -> Void)? = nil
    ) {
        callbackLoading?(true)
        request
            .receive(on: ExecutionContext.immediate)
            .observeNext(with: { result in
            switch result {
            case .success(let mContent):
                callbackLoading?(false)
                if let castResponse = mContent as? RESPONSE {
                    response.value = castResponse
                    callbackSuccess?()
                } else {
                    response.value = nil
                    print("BaseViewModel -> handleResourceToAPIState -> yanlış tip gönderdin.")
                    // %99 buraya düşmeyecek
                    errorState?.on(.next(.Error(errorType: .UNDEFINED_RESPONSE_TYPE)))
                }
                
            case .failure(let errorType):
                response.value = nil
                errorState?.on(.next(.Error(errorType: errorType)))
                errorState?.on(.next(.ErrorComplete))
                callbackLoading?(false)

            case.empty:
                callbackEmpty?()
            }
            callbackComplete?()

        }).dispose(in: self.disposeBag)
    }
}
