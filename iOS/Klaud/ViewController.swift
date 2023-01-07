
import UIKit
import WebKit
import Network


class ViewController: UIViewController{

    @IBOutlet weak var KlaudWebview: WKWebView!
    let monitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PageLoad()

        monitor.pathUpdateHandler = {
            path in if path.status == .satisfied {
                DispatchQueue.main.async {
                    
                }} else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "네트워크가 유실되었습니다!", message: "Klaud를 정상적으로 사용하기 위해서는 네트워크 환경에 접속되어야합니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "무시", style: .destructive) { action in
                            // 네트워크 연결 무시
                        })
                        self.present(alert, animated: true, completion: nil)
        }}}
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func PageLoad()
    {
        let pageName = "index"
        guard let url = Bundle.main.url(forResource: pageName, withExtension: "html", subdirectory: "WebResources") else {
            return
        }
        
        KlaudWebview.loadFileURL(url, allowingReadAccessTo: url)
        KlaudWebview.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        KlaudWebview.scrollView.isScrollEnabled = false
        KlaudWebview.scrollView.bounces = false
    }
    
    deinit {
        monitor.cancel()
    }
    
}
