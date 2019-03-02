import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
  
  var cameraVC: UIImagePickerController!
  
  enum ImageSource {
    case photoLibrary
    case camera
  }
  
  var image: UIImage?
  
  @IBAction func tappedCameraButton(_ sender: Any) {
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      selectImageFrom(.camera)
    }
  }
  
  func selectImageFrom(_ source: ImageSource){
    cameraVC =  UIImagePickerController()
    cameraVC.delegate = self
    switch source {
    case .camera:
      cameraVC.sourceType = .camera
    case .photoLibrary:
      cameraVC.sourceType = .photoLibrary
    }
    present(cameraVC, animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    let destVC = segue.destination as! ImageViewController
    destVC.imageToDisplay = image
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
}

extension ViewController: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    cameraVC.dismiss(animated: true, completion: nil);
    guard let selectedImage = info[.originalImage] as? UIImage else {
      print("Image not found!")
      return
    }
    image = selectedImage
    performSegue(withIdentifier: "imageDisplay", sender: self)
  }
}
