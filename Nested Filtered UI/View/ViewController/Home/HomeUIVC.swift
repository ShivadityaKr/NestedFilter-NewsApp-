//
//  HomeUIVC.swift
//  Nested Filtered UI
//
//  Created by Shivaditya Kumar on 16/04/22.
//

import UIKit

class HomeUIVC : NSObject {
    weak var view: HomeView? {
        didSet {
            setupUI()
        }
    }
    var viewModel: HomeDataSource? {
        didSet{
         setData()
        }
    }
    private func setData() {
        self.posts = self.viewModel?.dataSource ?? []
        self.allPost = self.viewModel?.dataSource ?? []
        self.view?.tableView.reloadData()
    }
    private func setupUI() {
        setFilterButton()
        setFilterTableView()
        setTableView()
    }
    private func setFilterButton() {
        self.view?.filterButton.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
    }
    var hide = false {
        didSet {
            if hide {
                UIView.transition(with:  (self.view?.filterTableView)!, duration: 0.4,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.view?.filterTableView.isHidden = false
                })
                self.view?.filterButton.setTitle("Close", for: .normal)
                self.view?.filterButton.tintColor = .black
            } else {
                UIView.transition(with:  (self.view?.filterTableView)!, duration: 0.4,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.view?.filterTableView.isHidden = true
                })
                self.view?.filterButton.setTitle("Filter", for: .normal)
                self.view?.filterButton.tintColor = .darkGray
            }
        }
    }
    var allPost : [Post] = []
    @objc func didTapFilterButton() {
        hide = !hide
        if hide == false {
            if selectedFilter.count != 0 {
//                By Using query parameter
//                posts = []
//                var tempPost = posts
//                for filter in selectedFilter {
//                    fetchData(query: filter)
//                    tempPost.append(contentsOf: posts)
//                }
//                posts = tempPost
//                posts.shuffle()
                var tempPost : [Post] = []
                for filter in selectedFilter {
                    for post in allPost {
                        if post.title.lowercased().contains(filter.lowercased()) || post.description.lowercased().contains(filter.lowercased()) {
                            if !tempPost.contains(where: {
                                $0.title == post.title
                            }) {
                                tempPost.append(post)
                            }
                        }
                    }
                }
                posts = Array(tempPost)
                print(posts.count)
            } else {
                posts = allPost
            }
            self.view?.tableView.reloadData()
        }
    }
    private func setFilterTableView() {
        self.view?.filterTableView.isHidden = true
        if #available(iOS 13.0, *) {
            self.view?.filterTableView.backgroundColor = .white
        } else {
            // Fallback on earlier versions
        }
        self.view?.filterTableView.delegate = self
        self.view?.filterTableView.dataSource = self
        openSection(id: 0)
        openSection(id: 1)
        self.view?.filterTableView.allowsMultipleSelectionDuringEditing = true
        self.view?.filterTableView.allowsMultipleSelection = true
        self.view?.filterTableView.register(UINib(nibName: "FilterTVC", bundle: nil), forCellReuseIdentifier: "FilterTVC")
    }
    private func setTableView() {
        self.view?.tableView.backgroundColor = .white
        self.view?.tableView.delegate = self
        self.view?.tableView.dataSource = self
        self.view?.tableView.allowsMultipleSelectionDuringEditing = false
        self.view?.tableView.register(UINib(nibName: "NewsListTVC", bundle: nil), forCellReuseIdentifier: "NewsListTVC")
    }
    var selectedFilter: [String] = []
    func setFilter(text: String) {
        if selectedFilter.contains(text) {
            selectedFilter.removeAll{ $0 == text }
        } else {
            selectedFilter.append(text)
        }
        if selectedFilter.count > 0 {
            self.view?.filterButton.setTitle("Done", for: .normal)
        } else {
            self.view?.filterButton.setTitle("Close", for: .normal)
        }
        print(selectedFilter as Any)
    }
    func openSection(id: Int) {
        let section = id
        sectionStats[section] = !sectionStats[section]
        self.view?.filterTableView.beginUpdates()
        self.view?.filterTableView.reloadSections([section], with: .automatic)
        self.view?.filterTableView.endUpdates()
    }
    var posts : [Post] = []
    var sectionStats = [Bool](repeating: true, count: 2)
}
extension HomeUIVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.view?.tableView {
            return 1
        } else {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.view?.tableView {
            if posts.count == 0 {
                return 1
            } else {
                return posts.count
            }
        } else {
            guard sectionStats[section] else {
                return 0
            }
            if section == 0 {
                return FilterData.sourceData.count
            } else {
                return FilterData.descData.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.view?.filterTableView {
            let cell = self.view?.filterTableView.dequeueReusableCell(withIdentifier: "FilterTVC") as! FilterTVC
            if indexPath.section == 0 {
                cell.setData(source: FilterData.sourceData[indexPath.row])
                return cell
            } else {
                cell.setData(desc: FilterData.descData[indexPath.row])
                return cell
            }
        } else {
            guard let cell = self.view?.tableView.dequeueReusableCell(withIdentifier: "NewsListTVC") as? NewsListTVC else {
                return UITableViewCell()
            }
            if posts.count != 0 {
                cell.setData(data: self.posts[indexPath.row])
            }
            else {
                let cell = UITableViewCell()
                cell.textLabel?.text = "No data Found"
                cell.textLabel?.textAlignment = .center
                return cell
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.view?.filterTableView {
            guard let cell = tableView.cellForRow(at: indexPath) as? FilterTVC else {
                return
            }
            if tableView == self.view?.filterTableView {
                cell.checked = !cell.checked
                selectedFilter(cell: cell)
            }
        } else if posts.count != 0 {
            let vc = DetailNewsVC.instantiate()
            vc.newsData = posts[indexPath.row]
            self.view?.present(vc, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.view?.tableView {
            return 200
        } else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.view?.filterTableView {
            let view = headerView(section: section, title: section == 0  ? "Source" : "Description")
            view.backgroundColor = .lightGray
            return view
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.view?.tableView {
            return 0
        }
        return 40
    }
    private func selectedFilter(cell: FilterTVC){
        setFilter(text: cell.titleLabel?.text ?? "")
    }
    private func headerView(section: Int, title: String) -> UIView {
        let button = UIButton(frame: CGRect.zero)
        button.tag = section
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.addTarget(self, action: #selector(sectionHeaderTapped), for: .touchUpInside)
        return button
    }
    @objc private func sectionHeaderTapped(sender: UIButton) {
        let section = sender.tag
        sectionStats[section] = !sectionStats[section]
        self.view?.filterTableView.beginUpdates()
        self.view?.filterTableView.reloadSections([section], with: .automatic)
        self.view?.filterTableView.endUpdates()
    }
}
struct FilterData {
    struct Source {
        let source: String
    }
    struct Description {
        let description: String
    }
    static var sourceData: [FilterData.Source] {
        return [
        Source(source: "India"),
        Source(source: "Ukraine"),
        Source(source: "Google"),
        Source(source: "China"),
        ]
    }
    static var descData: [FilterData.Description] {
        return [
        Description(description: "Covid"),
        Description(description: "Social Media"),
        Description(description: "War"),
        Description(description: "Entertainment"),
        ]
    }
}
