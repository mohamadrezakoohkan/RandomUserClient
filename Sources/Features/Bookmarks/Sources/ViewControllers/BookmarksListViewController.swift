//
//  BookmarksListViewController.swift
//  Bookmarks
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//


import Foundation
import UIKit
import CommonUtils
import CommonUI
import RxSwift

final class BookmarksListViewController: BaseViewController<BookmarksListStore> {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        let cellIdentifier = String(describing: UserDetailTableViewCell.self)
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        tableView.separatorStyle = .none
        tableView.rowHeight = UserDetailTableViewCell.rowHeight
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = CommonUIAsset.contentPrimary.color
        label.text = BookmarksStrings.Bookmarks.List.Empty.title
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dispatch(action: .appear)
    }
    
    override func setLayout(containerView: UIView) {
        
        tableView
            .disableAutoresizingMaskIntoConstraints()
            .add(toView: containerView)
            .horizontal(toConstraint: containerView.centerXAnchor)
            .width(toConstraint: containerView.widthAnchor)
            .top(toConstraint: containerView.safeAreaLayoutGuide.topAnchor, constant: CommonUtilsConstants.Sizes.verticalPadding)
            .bottom(toConstraint: containerView.safeAreaLayoutGuide.bottomAnchor)
        
        emptyLabel
            .disableAutoresizingMaskIntoConstraints()
            .add(toView: containerView)
            .horizontal(toConstraint: containerView.centerXAnchor)
            .vertical(toConstraint: tableView.centerYAnchor)
            .width(toConstraint: containerView.widthAnchor, constant: -CommonUtilsConstants.Sizes.horizontalPadding * 2)
    }
    
    override func update(fromStream stateObservable: Observable<BookmarksListState>) {
        
        let bookmarksObservable = stateObservable
            .map(\.bookmarks)
        
        bookmarksObservable
            .map { !$0.isEmpty }
            .bind(to: emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        bookmarksObservable
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items) { [weak self] (tableView, index, element) in
                let reuseId = String(describing: UserDetailTableViewCell.self)
                let indexPath = IndexPath(row: index, section: .zero)
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! UserDetailTableViewCell
                cell.user = element
                cell.isBookmarked = self?.currentState?.bookmarks.contains(element) == true
                return cell
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.dispatch(action: .selected(indexPath.row))
            }).disposed(by: disposeBag)
    }
}
