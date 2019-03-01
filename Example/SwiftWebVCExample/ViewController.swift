//
//  ViewController.swift
//  SwiftWebVCExample
//
//  Created by Myles Ringle on 20/12/2016.
//  Copyright © 2016 Myles Ringle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Push
    @IBAction func push() {
        let webVC = SwiftWebVC(urlString: "https://www.google.com")
        webVC.delegate = self
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    @IBAction func pushWithoutToolBar() {
        let webVC = SwiftWebVC(urlString: "https://www.google.com", hideToolBar: true)
        webVC.delegate = self
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    // MARK: Modal
    @IBAction func presentModalWithDefaultTheme() {
        let webVC = SwiftModalWebVC(urlString: "www.google.com")
        self.present(webVC, animated: true, completion: nil)
    }
    
    @IBAction func presentModalWithLightBlackTheme() {
        let webVC = SwiftModalWebVC(urlString: "https://www.google.com", theme: .lightBlack, dismissButtonStyle: .cross)
        self.present(webVC, animated: true, completion: nil)
    }
    
    @IBAction func presentModalWithDarkTheme() {
        let webVC = SwiftModalWebVC(urlString: "https://www.google.com", theme: .dark, dismissButtonStyle: .arrow)
        self.present(webVC, animated: true, completion: nil)
    }

}

extension ViewController: SwiftWebVCDelegate {

    func doneTappedOnSwiftWebVC(_ swiftWebVC: SwiftWebVC) {
        swiftWebVC.dismiss(animated: true, completion: nil)
    }

    func swiftWebVC(_ swiftWebVC: SwiftWebVC, didStartLoadingPage url: URL?) {
        print("Started loading. \(url)")
    }

    func swiftWebVC(_ swiftWebVC: SwiftWebVC, didFinishLoading isSuccess: Bool, page url: URL?) {
        print("Finished loading. Success: \(isSuccess).")
    }

    func swiftWebVC(_ swiftWebVC: SwiftWebVC, didReceiveResponse response: URLResponse) {
        print("Did receive response \(response)")
    }

    func swiftWebVC(_ swiftWebVC: SwiftWebVC, didDecideNavigationPolicy url: URL) {
        print("Did decideNavigationPolicy for \(url)")
    }

}
