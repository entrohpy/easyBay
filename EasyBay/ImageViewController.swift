import UIKit

class ImageViewController: UIViewController {

  var imageToDisplay: UIImage?
  
  
    override func viewDidLoad() {
      super.viewDidLoad()

      let imageView = UIImageView(image: imageToDisplay!)
      imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
      view.addSubview(imageView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
