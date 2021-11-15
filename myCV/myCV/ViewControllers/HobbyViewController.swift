//
//  HobbyViewController.swift
//  myCV
//
//  Created by Red Beard on 12.11.2021.
//

import UIKit

class HobbyViewController: UIViewController, UIScrollViewDelegate {
    
    var concerts: [Concert]!
    
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configuireScrollView()
        configuirePageControl()
        configuireLayout()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    private func configuireScrollView() {
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(
            width: view.frame.width * CGFloat(concerts.count),
            height: view.safeAreaInsets.bottom - view.safeAreaInsets.top
        )

        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configuirePageControl() {
        pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = concerts.count
        pageControl.currentPage = 0
    }
    
    private func configuireLayout() {
        let screenSize = UIScreen.main.bounds
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -screenSize.height * 0.1)
        ])
        
        configuireLayoutScrollView()
    }
    
    private func configuireLayoutScrollView() {
        let slides = createConcertSlides()
        
        var prevView: UIView = scrollView
        for slide in slides {
            scrollView.addSubview(slide)
            
            NSLayoutConstraint.activate([
                slide.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
                slide.leadingAnchor.constraint(equalTo: prevView.trailingAnchor),
                slide.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
                slide.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
            
            prevView = slide
        }
    }
    
    private func createConcertSlides() -> [ConcertView] {
        var result: [ConcertView] = []
        
        for concert in concerts {
            result.append(ConcertView(concert: concert))
        }
        return result
    }

}
