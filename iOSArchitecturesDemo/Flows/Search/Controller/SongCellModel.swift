//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Михаил Киржнер on 25.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation

 struct SongCellModel {
     let title: String
     let subtitle: String?
 }

 final class SongCellModelFactory {

     static func cellModel(from model: ITunesSong) -> SongCellModel {
         return SongCellModel(title: model.artistName ?? "",
                             subtitle: model.collectionName ?? "")
     }
 }
