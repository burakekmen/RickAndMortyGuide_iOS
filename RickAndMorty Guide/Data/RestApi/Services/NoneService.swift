//
//  NoneService.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import Moya

// Eğer ki repository'nizde api işlemleri yapmayacaksanız,
// base repository'e service target verilmesi zorunlu olduğu için
// NonService verebilirsiniz, ancak kullanamazsınız. [NO BEST PRACTISE]
enum NoneService {

}

extension NoneService: MTargetType {

    var path: String {
        return ""
    }

    var method: MoyaMethod {
        return .get
    }

    var task: MoyaTask {
        return .requestPlain
    }

    var isAuthorization: Bool {
        return false
    }
}
