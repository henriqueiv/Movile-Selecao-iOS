//
//  ViewController.swift
//  Movile-selecao-ios
//
//  Created by Henrique Valcanaia on 2/26/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import DZNEmptyDataSet
import SVProgressHUD
import UIKit

class ShowsListViewController: UIViewController {
    
    var presenter = ShowsListPresenter()
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Private vars
    private var shows = [ShowDisplayObject]()
    
    // MARK: Private consts
    private let refreshControl = UIRefreshControl()
    
    private struct Constants {
        let ImageCellTag = 10
        let LabelCellTag = 20
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        presenter.view = self
        loadData()
    }
    
    // MARK: Private helpers
    private func setupCollectionView() {
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(ShowsListViewController.loadData), forControlEvents: .ValueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    @objc private func loadData(){
        let stringDate = NSDate().stringDateWithFormat("MMM d, h:mm a")
        let title = "Last update: \(stringDate)"
        let attrsDictionary = [NSForegroundColorAttributeName:UIColor.grayColor()]
        let attributedTitle = NSAttributedString(string: title, attributes: attrsDictionary)
        refreshControl.attributedTitle = attributedTitle
        if !refreshControl.refreshing {
            refreshControl.beginRefreshing()
        }
        
        presenter.reloadView()
    }
    
}


// MARK: - UICollectionViewDelegate
extension ShowsListViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}

// MARK: - UICollectionViewDataSource
extension ShowsListViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ShowCell", forIndexPath: indexPath) as! ShowCollectionViewCell
        let show = shows[indexPath.row]
        
        cell.configureCellWithShow(show)
        
        return cell
    }
    
}

extension ShowsListViewController: ShowsListInterface {
    
    func displayError(error: ErrorType) {
        SVProgressHUD.showErrorWithStatus("Ops, ocorreu um erro ao tentar carregar as trending series. \nDetalhes: \(error)")
    }
    
    func setDisplayObjects(objects: [ShowDisplayObject]) {
        shows = objects
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func setViewEmpty(empty: Bool) {
        if empty {
            shows = []
        }
    }
    
    func didFinishRequestData() {
        if refreshControl.refreshing {
            refreshControl.endRefreshing()
            collectionView.contentOffset = CGPointMake(0, -refreshControl.frame.size.height)
        }
    }
    
}

extension ShowsListViewController: DZNEmptyDataSetSource {
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "sad")
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Oops, no treding series for you at the moment")
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Tap the screen to retry")
    }
    
}

extension ShowsListViewController: DZNEmptyDataSetDelegate {
    
    func emptyDataSet(scrollView: UIScrollView!, didTapView view: UIView!) {
        presenter.reloadView()
    }
    
}