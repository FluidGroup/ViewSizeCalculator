//
//  ViewController.swift
//  ViewSizeCalculator_Example
//
//  Created by muukii on 7/22/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources
import ViewSizeCalculator

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _items: [Item] = [
            Item(
                identity: "1",
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis porttitor dictum posuere.",
                message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis porttitor dictum posuere. Vivamus ligula magna, vestibulum quis cursus at, tristique quis ipsum. Sed lorem dui, ultrices nec porttitor non, lacinia vitae neque."
            ),
            Item(
                identity: "2",
                title: "Lorem ipsum dolor",
                message: "Lorem ipsum dolor"
            ),
            Item(
                identity: "3",
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis porttitor dictum posuere. Vivamus ligula magna, vestibulum quis cursus at, tristique quis ipsum. Sed lorem dui, ultrices nec porttitor non, lacinia vitae neque.",
                message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis porttitor dictum posuere. Vivamus ligula magna, vestibulum quis cursus at, tristique quis ipsum. Sed lorem dui, ultrices nec porttitor non, lacinia vitae neque."
            ),
            Item(
                identity: "4",
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis porttitor dictum posuere. Vivamus ligula magna, vestibulum quis cursus at,",
                message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis porttitor dictum posuere. Vivamus ligula magna, vestibulum quis cursus at, tristique quis ipsum. Sed lorem dui,"
            ),
            Item(
                identity: "5",
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis porttitor dictum posuere. Vivamus ligula magna, vestibulum quis cursus at, tristique quis ipsum. Sed lorem dui, ultrices nec porttitor non, lacinia vitae neque. Curabitur nunc tellus, congue sit amet tempor cursus, fermentum semper dolor. Duis ut erat in erat tempus sollicitudin. Donec mattis, arcu in finibus cursus, odio eros dignissim augue, ut accumsan sapien nisl id massa. In euismod nisi feugiat, accumsan nisl eu, maximus risus. Nulla id nisl nec turpis porttitor viverra.",
                message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis porttitor dictum posuere. Vivamus ligula magna, vestibulum quis cursus at, tristique quis ipsum. Sed lorem dui, ultrices nec porttitor non, lacinia vitae neque. Curabitur nunc tellus, congue sit amet tempor cursus, fermentum semper dolor. Duis ut erat in erat tempus sollicitudin. Donec mattis, arcu in finibus cursus, odio eros dignissim augue, ut accumsan sapien nisl id massa. In euismod nisi feugiat, accumsan nisl eu, maximus risus. Nulla id nisl nec turpis porttitor viverra."
            ),
            Item(
                identity: "6",
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis porttitor dictum posuere. Vivamus ligula magna, vestibulum quis cursus at, tristique quis ipsum. Sed lorem dui, ultrices nec porttitor non, ",
                message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
            ),
        ]
        
        items.value = [SectionModel<String, Item>(model: "", items: _items)]
        
        dataSource.configureCell = { dataSoucre, tableView, indexPath, model in
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! Cell
            cell.update(item: model)
            return cell
        }
        
        items.asDriver()
            .drive(tableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(disposeBag)
        
        tableView.delegate = self
    }
    
    struct Item {
        
        let identity: String
        let title: String
        let message: String
    }
    
    private let disposeBag = DisposeBag()
    private let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Item>>()
    private let items = Variable<[SectionModel<String, Item>]>([])
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var calculator: ViewSizeCalculator<Cell>?
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let item = dataSource.itemAtIndexPath(indexPath)
        
        if calculator == nil {
            calculator = ViewSizeCalculator(
                sourceView: tableView.dequeueReusableCellWithIdentifier("Cell") as! Cell,
                calculateTargetView: { $0.contentView }
            )
        }
        
        guard let calculator = calculator else {
            return 0
        }
                
        let heihgt = calculator.calculate(width: tableView.bounds.width, height: nil, cacheKey: item.identity) { (cell) in
            cell.update(item: item)
        }
        .height
        
        return heihgt + 1 / UIScreen.mainScreen().scale
    }
}
