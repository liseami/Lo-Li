//
//  PublicFuncs.swift
//  Fantline
//
//  Created by Liseami on 2021/12/14.
//

import CoreData
import CoreImage.CIFilterBuiltins
import Foundation
import MobileCoreServices
import PhotosUI
import SwifterSwift
import SwiftUI
import UIKit
import UniformTypeIdentifiers

/*
 函数计时
 */
func timeLookFunc<T>(function: () -> T) {
    let start = Date()
    _ = function()
    let end = Date()
    let timeInterval: TimeInterval = end.timeIntervalSince(start)
    print("————————————————————————————————————————————————————")
    print("函数'\(#function)'共耗时：\(timeInterval * 1000) 毫秒")
}

// MARK: 自定义导航栏

public func CustomUIAppearance() {
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().isTranslucent = true
    UINavigationBar.appearance().scrollEdgeAppearance?.backgroundColor = .clear
    let appearance = UINavigationBarAppearance()
    appearance.setBackIndicatorImage(UIImage(named: "navibackbtn")?.withRenderingMode(.alwaysOriginal), transitionMaskImage: UIImage(named: "navibackbtn"))
    appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
    UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.black)
}

public func goToSetting() {
    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
        UIApplication.shared.open(settingsUrl)
    }
}

public func changeNavigationBarApp(UINavigationController: UINavigationController, changeTo: UINavigationBarAppearance) {
    UINavigationController.navigationBar.standardAppearance = changeTo
    UINavigationController.navigationBar.scrollEdgeAppearance = changeTo
//    UINavigationController.navigationBar.compactScrollEdgeAppearance = changeTo
}

func readStringFromFile() -> String? {
    let fileName = "Dao.txt"
    let filePath = Bundle.main.path(forResource: fileName, ofType: nil)

    do {
        let content = try String(contentsOfFile: filePath!, encoding: .utf8)
        print(content)
        return content
    } catch {
        print("Failed to read file: \(error)")
        return nil
    }
}

public func randomString(_ length: Int?) -> String {
    let randomLengthInt = Int.random(in: 1 ... 100)
    let letters = readStringFromFile() ?? "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    if length != nil { return String((0 ..< length!).map { _ in letters.randomElement()! }) }
    else {
        return String((0 ..< randomLengthInt).map { _ in letters.randomElement()! })
    }
}

// 保存Croedata数据
public func coreDataSave(onComplete: @escaping () -> (), onError: @escaping () -> ()) {
    PersistenceController.shared.saveData(onComplete: onComplete, onError: onError)
}

// 图片数组转Base64字符串...
func mixUIimageByBase64String(uiimages: [UIImage]) -> String? {
    var allImageBase64 = String()
    if uiimages.isEmpty {
        return nil
    } else {
        for uiimage in uiimages {
            let oneImageBase64 = uiimage.toBase64String().isEmpty ? "" : "data:image/jpeg;base64," + uiimage.toBase64String() + "&"
            allImageBase64.append(oneImageBase64)
        }
        allImageBase64 = allImageBase64.removingSuffix("&")
    }
    return allImageBase64
}

func getEntityArray<E>() -> [E] where E: NSManagedObject {
    let fetchRequest = NSFetchRequest<E>(entityName: String(describing: E.self))
    do {
        let arr = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return arr
    } catch {
        return []
    }
}

/// 从String绘制二维码
/// - Parameter url
/// - Returns:返回UIImage
func generateQRCode(from string: String) -> UIImage {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    filter.message = Data(string.utf8)
    if let outputImage = filter.outputImage {
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgimg)
        }
    }
    return UIImage(systemName: "xmark.circle") ?? UIImage()
}

/*
 获取图片主色
 */
func getImageMainColor(image: UIImage, completion: @escaping (UIColor) -> ()) {
    DispatchQueue.global(qos: .background).async {
        let cgImage = image.cgImage
        let width = cgImage!.width
        let height = cgImage!.height

        var pixelData = [UInt8](repeating: 0, count: width * height * 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 4 * width, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)

        context?.draw(cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))

        var r = 0, g = 0, b = 0
        for x in 0 ..< width {
            for y in 0 ..< height {
                let index = 4 * (x * y)
                r += Int(pixelData[index])
                g += Int(pixelData[index + 1])
                b += Int(pixelData[index + 2])
            }
        }
        let total = width * height
        r /= total
        g /= total
        b /= total

        let result = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

/*
 延时执行函数
 */
func delayWork(_ delay: Double, _ callback: @escaping () -> ()) {
    let time = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: time) {
        callback()
    }
}



/*
 从秒数返回 小时/分/秒 三元组
 */
public func secsToTimeOClock(secs: Int) -> (Int, Int, Int) {
    let hours = Int(secs / 3600)
    let minutes = Int((secs % 3600) / 60)
    let seconds = Int(secs % 60)
    return (hours, minutes, seconds)
}

/*
 模拟延时
 */
func waitme() async {
    await Task.sleep(1 * 1000000000) // 等待3秒钟
}
