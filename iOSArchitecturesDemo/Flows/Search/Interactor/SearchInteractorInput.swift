//
//  SearchInteractorInput.swift
//  iOSArchitecturesDemo
//
//  Created by Михаил Киржнер on 03.05.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
 import Alamofire

 protocol SearchInteractorInput {

     func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void)
 }

 final class SearchInteractor: SearchInteractorInput {

     private let searchService = ITunesSearchService()

     func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void) {
         self.searchService.getApps(forQuery: query, then: completion)
     }
 }
