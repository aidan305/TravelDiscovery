//
//  DestinationHeaderContainer.swift
//  TravelDiscovery
//
//  Created by aidan egan on 28/10/2020.
//

import SwiftUI
import Kingfisher

struct DestinationHeaderContainer: UIViewControllerRepresentable{
    
    let imageUrlStrings : [String]
    let selectionIndex: Int
    
    func makeUIViewController(context: Context) -> UIViewController {
        let pvc = CustomPageViewController(imageUrlStrings: imageUrlStrings, selectedIndex: selectionIndex)
        return pvc
    }
    typealias UIViewControllerType = UIViewController
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    var allControllers: [UIViewController] = []
    var selectedIndex : Int
    
    init(imageUrlStrings: [String], selectedIndex: Int){
        
        self.selectedIndex = selectedIndex
        
        //show red dots on page view controller
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        allControllers = imageUrlStrings.map({ imageName in
            let hostingController = UIHostingController(rootView:
                                                            KFImage(URL(string: imageName)).resizable().scaledToFill()
            )
            return hostingController
        })
        
        if selectedIndex < allControllers.count {
            setViewControllers([allControllers[selectedIndex]], direction: .forward, animated: true, completion: nil)
        }
        
        //setViewControllers([allControllers.first!], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.delegate = self
    }
    
    //data source required functions
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else {return nil}
        
        if index == 0 {return nil}
        return allControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else {return nil}
        
        if index == allControllers.count - 1 {return nil}
        return allControllers[index + 1]
    }
    
    //delegate functions (not required but shows the dots in the page view controller)
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        allControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        selectedIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct DestinationHeaderContainer_Previews: PreviewProvider {
    
    static let imageUrlStrings = ["https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/7156c3c6-945e-4284-a796-915afdc158b5", "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/6982cc9d-3104-4a54-98d7-45ee5d117531", "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/2240d474-2237-4cd3-9919-562cd1bb439e"]
    
    static var previews: some View {
        
        DestinationHeaderContainer(imageUrlStrings: imageUrlStrings, selectionIndex: 1).frame(height: 300)
        
        NavigationView{
            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235))
        }
    }
}
