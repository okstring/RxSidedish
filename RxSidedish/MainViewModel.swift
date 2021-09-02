//
//  MainViewModel.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import RxDataSources

typealias SidedishSectionModel = AnimatableSectionModel<Int, SidedishItem>

class MainViewModel: CommonViewModel {
    let dataSource: RxTableViewSectionedAnimatedDataSource<SidedishSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<SidedishSectionModel> { (dataSource, tableView, indexPath, sidedishItem) -> UITableViewCell in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.className) as? MainTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(item: sidedishItem)
            return cell
        }
        
        return ds
    }()
    
    
}
