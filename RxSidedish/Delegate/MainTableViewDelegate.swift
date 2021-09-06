//
//  MainTableViewDelegate.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/06.
//

import UIKit

class MainTableViewDelegate: NSObject {
    var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
}

extension MainTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableViewHeaderView.className) as? MainTableViewHeaderView else { return UIView() }
        view.configure(sectionModel: viewModel.dataSource.sectionModels[section])
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
