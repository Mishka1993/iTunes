//
//  SearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Михаил Киржнер on 25.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

 final class SearchModuleBuilder {

     static func appBuild() -> (UIViewController & AppSearchViewInput) {
         let presenter = AppSearchPresenter()
         let viewController = AppSearchViewController(presenter: presenter)
         presenter.viewInput = viewController
         return viewController
     }

     static func songBuild() -> (UIViewController & SongSearchViewInput) {
         let presenter = SongSearchPresenter()
         let viewController = SongSearchViewController(presenter: presenter)
         presenter.viewInput = viewController
         return viewController
     }
 }
