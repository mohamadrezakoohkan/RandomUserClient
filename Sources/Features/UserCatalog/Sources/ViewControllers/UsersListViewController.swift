//
//  UsersListViewController.swift
//  UserCatalog
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import UIKit
import CommonUtils
import CommonUI
import RxSwift
import RxCocoa

fileprivate enum UsersListSection {
    case all
}

final class UsersListViewController: BaseViewController<UsersListStore> {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = UserCatalogStrings.UsersList.Search.placeholder
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        return tableView
    }()
    
    private let loadingView: SpinnerLoadingView = {
        let loadingView = SpinnerLoadingView()
        loadingView.hide()
        return loadingView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dispatch(action: .appear)
    }
    
    override func setLayout(containerView: UIView) {
        searchBar
            .disableAutoresizingMaskIntoConstraints()
            .add(toView: containerView)
            .horizontal(toConstraint: containerView.centerXAnchor)
            .width(toConstraint: containerView.widthAnchor, constant: -CommonUtilsConstants.Sizes.horizontalPadding)
            .top(toConstraint: containerView.safeAreaLayoutGuide.topAnchor, constant: CommonUtilsConstants.Sizes.verticalPadding)
        
        tableView
            .disableAutoresizingMaskIntoConstraints()
            .add(toView: containerView)
            .horizontal(toConstraint: containerView.centerXAnchor)
            .width(toConstraint: containerView.widthAnchor)
            .top(toConstraint: searchBar.bottomAnchor, constant: CommonUtilsConstants.Sizes.verticalMediumSpacing)
            .bottom(toConstraint: containerView.safeAreaLayoutGuide.bottomAnchor)
        
        loadingView
            .disableAutoresizingMaskIntoConstraints()
            .add(toView: containerView)
            .horizontal(toConstraint: containerView.centerXAnchor)
            .vertical(toConstraint: tableView.centerYAnchor)
    }
    
    override func update(fromStream stateObservable: Observable<UsersListState>) {
        
        let usersObservable = stateObservable
            .map(\.users)
        
        usersObservable
            .map(\.isEmpty)
            .bind(to: loadingView.rx.isLoading)
            .disposed(by: disposeBag)
        
        usersObservable
        // map or compine with latest state.bookmarks, to be able to cell.isBookmarked = bookmarks.contains(element.id)
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items) { (tableView, index, element) in
                let cell = UserDetailTableViewCell(style: .default, reuseIdentifier: "cell")
                cell.user = element
                return cell
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.dispatch(action: .selected(indexPath.row))
                self?.searchBar.searchTextField.endEditing(true)
            }).disposed(by: disposeBag)
        
        Observable.combineLatest(
            tableView.rx.willDisplayCell.map(\.indexPath.row),
            usersObservable.map(\.count),
            searchBar.rx.text
        ).filter { displayedIndex, usersCount, query in
            displayedIndex == usersCount - 2 && (query == nil || query == "") && usersCount > 0
        }.subscribe(onNext: { [weak self] _ in
            self?.dispatch(action: .loadNext)
        }).disposed(by: disposeBag)
        
        searchBar.rx.text
            .map { $0?.lowercased() }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                self?.dispatch(action: .search(query))
            }).disposed(by: disposeBag)
    }
}
