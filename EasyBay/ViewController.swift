import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


  var cameraVC: UIImagePickerController!

  var image: UIImage?
  var responseJSON: Dictionary<String, Any>?
  
  @IBAction func tappedCameraButton(_ sender: Any) {

    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      cameraVC =  UIImagePickerController()
      cameraVC.delegate = self
      cameraVC.sourceType = .camera
      present(cameraVC, animated: true, completion: nil)
    }
  }
  
  
  @IBAction func tappedUploadButton(_ sender: Any) {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      cameraVC =  UIImagePickerController()
      cameraVC.delegate = self
      cameraVC.sourceType = .photoLibrary
      present(cameraVC, animated: true, completion: nil)
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

    dismiss(animated: true, completion: nil);

    guard let selectedImage = info[.originalImage] as? UIImage else {
      print("Image not found!")
      return
    }
    image = selectedImage
    if let _ = image {
      performSegue(withIdentifier: "segueInputParams", sender: self)
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destVC = segue.destination as! InputParamsViewController
    destVC.image = UIImage(data: image!.jpegData(compressionQuality: 0.1)!)!
//    print (destVC.image!)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
