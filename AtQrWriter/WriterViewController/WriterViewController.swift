//
//  WriterViewController.swift
//  AtQrWriter
//
//  Created by David on 07/05/2019.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class WriterViewController: UIViewController {
    lazy var filter = CIFilter(name: "CIQRCodeGenerator")
    
    var text: String = ""
    @IBOutlet weak var tfQrText: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var ivQrImage: UIImageView!
    
    
    
    @IBAction func generateQrImage(){
        let text = tfQrText.text
        let data = text?.data(using: String.Encoding.ascii)
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        qrFilter.setValue(data, forKey: "inputMessage")
        guard let qrImage = qrFilter.outputImage else { return }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        ivQrImage.image = convertCIImageToUIImage(cmage: scaledQrImage)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func convertCIImageToUIImage(cmage:CIImage) -> UIImage
    {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }

}
