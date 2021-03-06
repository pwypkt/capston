//
//  ViewController.swift
//  cap3
//
//  Created by RelMac User Exercise1 on 2021/06/19.
//

/*
 
import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   

    
}

*/

import UIKit
import MobileCoreServices // 다양한 타입들을 정의해 놓은 헤더 파일 추가

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var cameraa: UIButton!
    @IBOutlet weak var gallary: UIButton!
    @IBOutlet weak var info: UIButton!
    @IBOutlet weak var timer: UIButton!
    @IBOutlet weak var cbutton1: UIButton!
    @IBOutlet weak var cbutton2: UIButton!
    @IBOutlet weak var cbutton3: UIButton!
    @IBOutlet weak var image2: UIImageView!
    
    
    var buttonflag = 0
    var numImage = 1 // 이미지 뷰를 가르키는 변수
    var timelack = 0
    //timer
      var mTimer : Timer?
      var number : Int = 0


    @IBOutlet var imgView: UIImageView!
    //@IBOutlet var imgView2: UIImageView!
   // @IBOutlet var imgView3: UIImageView!
    
    // UIImagePickerController 인스턴스 변수 생성
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var flagImageSave = false // 사진 저장 여부를 나타낼 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cbutton1.isHidden = true
        cbutton2.isHidden = true
        cbutton3.isHidden = true
        image2.isHidden = true
        // Do any additional setup after loading the view.
    }

    
    // 사진 촬영
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        
        // 만일 카메라를 사용할 수 있다면
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true // 사진 저장 플래그를 true로 설정
            
            imagePicker.delegate = self // 이미지 피커의 델리케이트를 self로 설정
            imagePicker.sourceType = .camera // 이미지 피커의 소스 타입을 Camera로 설정
            imagePicker.mediaTypes = [kUTTypeImage as String] // 미디어 타입을 kUTTypeImage로 설정
            imagePicker.allowsEditing = false // 편집을 허용하지 않음
            
            // 뷰 컨트롤러를 imagePicker로 대체
            present(imagePicker, animated: true, completion: nil)
        } else {
            // 카메라를 사용할 수 없을 때 경고 창 출력
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    @IBAction func selectImage(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary // 이미지 피커의 소스 타입을 PotoLibrary로 설정
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true // 편집을 허용
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo albm.")
        }
        
    }
    
    
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary // 이미지 피커의 소스 타입을 PotoLibrary로 설정
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true // 편집을 허용
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo albm.")
        }
    }


    
    // 초기화
    @IBAction func btnImgViewReset(_ sender: UIButton) {
        imgView.image = nil
       // imgView2.image = nil
       /// imgView3.image = nil
        numImage = 1
    }
    
    // 사진 촬영이나 선택이 끝났을 때 호출되는 델리게이트 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 미디어 종류 확인
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        // 미디어가 사진이면
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            // 사진을 가져옴
            let captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            if flagImageSave { // flagImageSave가 true일 때
                // 사진을 포토 라이브러리에 저장
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            // 가져온 사진을 해당하는 이미지 뷰에 넣기...
            imgView.image = captureImage // 가져온 사진을 이미지 뷰에 출력

        }
        // 현재의 뷰(이미지 피커) 제거
        self.dismiss(animated: true, completion: nil)
    }
    
    // 사진 촬영이나 선택을 취소했을 때 호출되는 델리게이트 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 현재의 뷰(이미지 피커) 제거
        self.dismiss(animated: true, completion: nil)
    }
    
    // 경고 창 츨력 함수
    func myAlert(_ title: String,message: String) {
        // Alert show
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
 
    @IBAction func hidden(_ sender: Any) {
        if (buttonflag == 0)
        {
            info.isHidden=true
            cameraa.isHidden=true
            gallary.isHidden=true
            cbutton1.isHidden = false
            cbutton2.isHidden = false
            cbutton3.isHidden = false
            
            buttonflag = 1
        }
        else
        {
            info.isHidden=false
            cameraa.isHidden=false
            gallary.isHidden=false
            cbutton1.isHidden = true
            cbutton2.isHidden = true
            cbutton3.isHidden = true
            buttonflag = 0
            
        }
    }
    
    @IBAction func change1(_ sender: Any)
    {
        sleep(5)
        imgView.image = UIImage(named: "4")
    }
    
    @IBAction func change2(_ sender: Any)
    {
        sleep(5)
        imgView.image = UIImage(named: "3")
        
    }
    
    @IBAction func change3(_ sender: Any)
    {
        sleep(5)
        imgView.image = UIImage(named: "2")
        
    }
    
    
}


