//
//  SwiftModalWebVC.swift
//
//  Created by Myles Ringle on 24/06/2015.
//  Transcribed from code used in SVWebViewController.
//  Copyright (c) 2015 Myles Ringle & Oliver Letterer. All rights reserved.
//

import UIKit
import WebKit

public class SwiftModalWebVC: UINavigationController {
    
    private var theme: Theme = .lightBlue
    weak var webViewDelegate: UIWebViewDelegate? = nil
    
    public convenience init(urlString: String, configuration: WKWebViewConfiguration = WKWebViewConfiguration(), sharingEnabled: Bool = true) {
        var urlString = urlString
        if !urlString.hasPrefix("https://") && !urlString.hasPrefix("http://") {
            urlString = "https://"+urlString
        }
        self.init(pageURL: URL(string: urlString)!, configuration: configuration, sharingEnabled: sharingEnabled)
    }
    
    public convenience init(urlString: String, configuration: WKWebViewConfiguration = WKWebViewConfiguration(), theme: Theme, dismissButtonStyle: DismissButtonStyle, sharingEnabled: Bool = true, delegate: SwiftWebVCDelegate? = nil) {
        self.init(pageURL: URL(string: urlString)!, configuration: configuration, theme: theme, dismissButtonStyle: dismissButtonStyle, sharingEnabled: sharingEnabled, delegate: delegate)
    }
    
    public convenience init(pageURL: URL, configuration: WKWebViewConfiguration = WKWebViewConfiguration(), sharingEnabled: Bool = true, delegate: SwiftWebVCDelegate? = nil) {
        self.init(request: URLRequest(url: pageURL), configuration: configuration, sharingEnabled: sharingEnabled, delegate: delegate)
    }
    
    public convenience init(pageURL: URL, configuration: WKWebViewConfiguration = WKWebViewConfiguration(), theme: Theme, dismissButtonStyle: DismissButtonStyle, sharingEnabled: Bool = true, delegate: SwiftWebVCDelegate? = nil) {
        self.init(request: URLRequest(url: pageURL), configuration: configuration, theme: theme, dismissButtonStyle: dismissButtonStyle, sharingEnabled: sharingEnabled, delegate: delegate)
    }

    public convenience init(html: String, configuration: WKWebViewConfiguration = WKWebViewConfiguration(), theme: Theme = .lightBlue, dismissButtonStyle: DismissButtonStyle = .arrow, sharingEnabled: Bool = true, delegate: SwiftWebVCDelegate?) {
        self.init(request: nil, htmlString: html, configuration: configuration, theme: theme, dismissButtonStyle: dismissButtonStyle, sharingEnabled: sharingEnabled, delegate: delegate)
    }

    public convenience init(request: URLRequest, configuration: WKWebViewConfiguration = WKWebViewConfiguration(), theme: Theme = .lightBlue, dismissButtonStyle: DismissButtonStyle = .arrow, sharingEnabled: Bool = true, delegate: SwiftWebVCDelegate?) {
        self.init(request: request, htmlString: nil, configuration: configuration, theme: theme, dismissButtonStyle: dismissButtonStyle, sharingEnabled: sharingEnabled, delegate: delegate)
    }
    
    fileprivate init(request: URLRequest?, htmlString: String?, configuration: WKWebViewConfiguration = WKWebViewConfiguration(), theme: Theme = .lightBlue, dismissButtonStyle: DismissButtonStyle = .arrow, sharingEnabled: Bool = true, delegate: SwiftWebVCDelegate?) {
        let webViewController = htmlString == nil ? SwiftWebVC(aRequest: request!, configuration: configuration) : SwiftWebVC(html: htmlString!, configuration: configuration)
        webViewController.delegate = delegate
        webViewController.sharingEnabled = sharingEnabled
        webViewController.storedStatusColor = UINavigationBar.appearance().barStyle

        var doneButton: UIBarButtonItem
        switch dismissButtonStyle {
        case .arrow, .cross:
            let dismissButtonImageName = (dismissButtonStyle == .arrow) ? "SwiftWebVCDismiss" : "SwiftWebVCDismissAlt"
            doneButton = UIBarButtonItem(image: SwiftWebVC.bundledImage(named: dismissButtonImageName),
                                         style: UIBarButtonItem.Style.plain,
                                         target: webViewController,
                                         action: #selector(SwiftWebVC.doneButtonTapped))
        case .done:
            doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: webViewController,
                                         action: #selector(SwiftWebVC.doneButtonTapped))
        }

        switch theme {
        case .lightBlue:
            doneButton.tintColor = nil
            webViewController.buttonColor = nil
            webViewController.titleColor = UIColor.black
            UINavigationBar.appearance().barStyle = UIBarStyle.default
        case .lightBlack:
            doneButton.tintColor = UIColor.darkGray
            webViewController.buttonColor = UIColor.darkGray
            webViewController.titleColor = UIColor.black
            UINavigationBar.appearance().barStyle = UIBarStyle.default
        case .dark:
            doneButton.tintColor = UIColor.white
            webViewController.buttonColor = UIColor.white
            webViewController.titleColor = UIColor.groupTableViewBackground
            UINavigationBar.appearance().barStyle = UIBarStyle.black
        }

        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            webViewController.navigationItem.leftBarButtonItem = doneButton
        }
        else {
            webViewController.navigationItem.rightBarButtonItem = doneButton
        }
        super.init(rootViewController: webViewController)
        self.theme = theme
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return theme == .dark ? .lightContent : .default
    }

}

extension SwiftModalWebVC {

    public enum Theme {
        case lightBlue, lightBlack, dark
    }

    public enum DismissButtonStyle {
        case arrow, cross, done
    }

}
