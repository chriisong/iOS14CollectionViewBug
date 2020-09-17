//
//  CollectionViewController.swift
//  CollectionViewBug
//
//  Created by Chris Song on 2020-09-17.
//

import UIKit

class CollectionViewBugVC: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    var snapshot: NSDiffableDataSourceSnapshot<Int, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureNavigationItem()
        configureSearchController()
        configureDataSource()
    }
    func configureHierarchy() {
        view.backgroundColor = .systemBackground
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CompositionalLayout.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
        collectionView.register(CollectionViewBugCell.self, forCellWithReuseIdentifier: CollectionViewBugCell.reuseIdentifier)
    }
    func configureNavigationItem() {
        navigationItem.title = "iOS 14 Bug"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewBugCell.reuseIdentifier, for: indexPath) as? CollectionViewBugCell else { fatalError("") }
            return cell
        })
        setupSnapshot()
    }
    func setupSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([1])
        snapshot.appendItems([1], toSection: 1)
        DispatchQueue.main.async {
            self.dataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
    
}
extension CollectionViewBugVC: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    private func configureSearchController() {
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Search by iOS 14 Bugs 👀"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
    func updateSearchResults(for searchController: UISearchController) {}
    func willPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchResultsController?.view.isHidden = false
        }
    }
}


class CompositionalLayout {
    static func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        section.interGroupSpacing = 15
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
