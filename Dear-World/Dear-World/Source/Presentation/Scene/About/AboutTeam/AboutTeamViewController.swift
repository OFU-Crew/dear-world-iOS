//
//  AboutTeamViewController.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/04.
//

import Then
import ReactorKit
import UIKit

final class AboutTeamViewController: UIViewController, View {
  
  typealias Reactor = AboutTeamReactor
  
  // MARK: 🖼 UI
  private let scrollView: UIScrollView = UIScrollView()
  private let crewsCollectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )
  private let moreButton: UIButton = UIButton()
  private let backButton: UIButton = UIButton()
  
  var disposeBag: DisposeBag = DisposeBag()
  
  // MARK: 🏁 Initialize
  init() {
    super.init(nibName: nil, bundle: nil)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: 🎛 Setup
  private func setupUI() {
    self.view.backgroundColor = .breathingWhite
    self.navigationController?.isNavigationBarHidden = true
  
//    self.view.snp.makeConstraints {
//      $0.edges.equalToSuperview()
//      $0.width.equalTo(UIScreen.main.bounds.width)
//    }
    
    let headerView: UIView = UIView().then {
      $0.backgroundColor = .warmBlue
    }
    self.view.addSubview(headerView)
    headerView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(240)
    }
    
    self.view.addSubview(backButton)
    backButton.do {
      $0.setBackgroundImage(UIImage(named: "backWhite"), for: .normal)
    }
    backButton.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(37)
    }
    
    let teamGreetingTitleLabel: UILabel = UILabel().then {
      $0.text = "Hello, we are team OFU!"
      $0.font = .boldSystemFont(ofSize: 16)
      $0.textColor = .warmBlue
    }
    let teamGreetingLabel: UILabel = UILabel().then {
      $0.text = """
        Since Corona bothering the world, we start the project to
        make people can encouraged themselves by writting their
        stories on it. Our OFU crew always cheers you and hope we all overcome this corona blue.
        """
      $0.font = .systemFont(ofSize: 12)
      $0.textColor = .nightBlue
      $0.numberOfLines = 0
    }
    self.view.addSubview(teamGreetingTitleLabel)
    self.view.addSubview(teamGreetingLabel)
    teamGreetingTitleLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.top.equalTo(headerView.snp.bottom).offset(30)
    }
    teamGreetingLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.top.equalTo(teamGreetingTitleLabel.snp.bottom).offset(10)
    }
    
    let crewsTitleLable: UILabel = UILabel().then {
      $0.text = "OFU CREWS"
      $0.textColor = .warmBlue
      $0.font = .boldSystemFont(ofSize: 16)
    }
    self.view.addSubview(crewsTitleLable)
    crewsTitleLable.snp.makeConstraints {
      $0.top.equalTo(teamGreetingLabel.snp.bottom).offset(50)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    self.view.addSubview(crewsCollectionView)
    crewsCollectionView.do {
      $0.register(CrewCollectionViewCell.self, forCellWithReuseIdentifier: "CrewCollectionViewCell")
      $0.backgroundColor = .breathingWhite
      $0.delegate = self
      $0.allowsSelection = false
    }
    crewsCollectionView.snp.makeConstraints {
      $0.top.equalTo(crewsTitleLable.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(440)
    }
    
    let footerView: UIView = UIView().then {
      $0.backgroundColor = .livelyBlue
    }
    self.view.addSubview(footerView)
    footerView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(144)
      $0.top.equalTo(crewsCollectionView.snp.bottom).offset(100)
    }
    
    footerView.addSubview(moreButton)
    moreButton.do {
      $0.backgroundColor = .illuminatingYellow
      $0.setTitle("More about OFU CREW", for: .normal)
      $0.titleLabel?.font = .systemFont(ofSize: 14)
      $0.layer.cornerRadius = 10
      $0.setTitleColor(.warmBlue, for: .normal)
    }
    moreButton.snp.makeConstraints {
      $0.top.equalToSuperview().inset(15)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(48)
    }
    
    let copyrightLabel: UILabel = UILabel().then {
      $0.text = "ⓒ OFU 2021. Made in Korea"
      $0.font = .systemFont(ofSize: 14)
      $0.textColor = .breathingWhite
    }
    footerView.addSubview(copyrightLabel)
    copyrightLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(moreButton.snp.bottom).offset(25)
    }
  }
  
  // MARK: 🔗 Bind
  func bind(reactor: AboutTeamReactor) {
    reactor.state.map { $0.crews }
      .bind(to: crewsCollectionView.rx.items(cellIdentifier: "CrewCollectionViewCell", cellType: CrewCollectionViewCell.self)) { index, crew, cell in
        cell.configure(crew)
      }
      .disposed(by: disposeBag)
    
    reactor.action.onNext(.initialize)
  }
  
}
extension AboutTeamViewController: UICollectionViewDelegateFlowLayout {
  private var inset: CGFloat { 20 }
  private var itemSpacing: CGFloat { 48 }
  var itemWidth: CGFloat {
    (UIScreen.main.bounds.width - (inset * 2) - (itemSpacing * 2)) / 3
  }
  var itemHeight: CGFloat {
    itemWidth * 1.5
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    CGSize(width: itemWidth, height: itemHeight)
  }
}

struct Crew {
  let name: String
  let role: String
  let profileImage: UIImage
}
extension Crew {
  static let all: [Crew] = [
    Crew(name: "Judy", role: "PM, Design", profileImage: UIImage(named: "Judy")!),
    Crew(name: "Pengin", role: "Backend Dev", profileImage: UIImage(named: "Pengin")!),
    Crew(name: "Owl", role: "iOS Dev", profileImage: UIImage(named: "Owl")!),
    Crew(name: "Rookie", role: "iOS Dev", profileImage: UIImage(named: "Rookie")!),
    Crew(name: "Ifmoon", role: "Frontend Dev", profileImage: UIImage(named: "Ifmoon")!),
    Crew(name: "Minsour", role: "Frontend Dev", profileImage: UIImage(named: "Minsour")!),
    Crew(name: "Chipmunk", role: "Backend Dev", profileImage: UIImage(named: "Chipmunk")!),
    Crew(name: "YuChoco", role: "Android Dev", profileImage: UIImage(named: "YuChoco")!),
    Crew(name: "Peter", role: "Android Dev", profileImage: UIImage(named: "Peter")!)
  ]
}

final class CrewCollectionViewCell: UICollectionViewCell {
  private let profileImageView: UIImageView = UIImageView()
  private let nameLabel: UILabel = UILabel()
  private let roleLabel: UILabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupUI()
  }
  
  private func setupUI() {
    self.addSubview(profileImageView)
    profileImageView.snp.makeConstraints {
      $0.width.height.equalTo(self.bounds.width)
    }
    
    self.addSubview(nameLabel)
    nameLabel.do {
      $0.textAlignment = .center
      $0.font = .systemFont(ofSize: 12)
      $0.textColor = .warmBlue
    }
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
    }
    
    self.addSubview(roleLabel)
    roleLabel.do {
      $0.textAlignment = .center
      $0.font = .systemFont(ofSize: 10)
      $0.textColor = .livelyBlue
    }
    roleLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  func configure(_ crew: Crew) {
    nameLabel.text = crew.name
    roleLabel.text = crew.role
    profileImageView.image = crew.profileImage
  }
}
