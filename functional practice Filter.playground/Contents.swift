//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

typealias Filter = CIImage -> CIImage

func add2(x: Int) -> (Int->Int) {
    return { y in return x+y }
}

add2(3)(1)



//blur filter

func blur(radius: Double) -> Filter {
    return { image in
        let parametrs = [kCIInputRadiusKey: radius,
                         kCIInputImageKey: image]
        
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parametrs) else {fatalError()}
        guard let outputImage = filter.outputImage else {fatalError()}
        return outputImage
    }
}

//color overlay

func colorGenerator(color: UIColor) -> Filter {
    return { _ in
        let c = CIColor(color: color)
        let parametrs = [kCIInputColorKey: c]
        guard let filter = CIFilter(name: "CICostantColorGenerator", withInputParameters: parametrs) else {fatalError() }
        guard let outputImgae = filter.outputImage else {fatalError()}
        return outputImgae
    }
    
}


//composite filters

func compositeSourceOver(overlay: CIImage) -> Filter {
    return { image in
        let parametrs = [
            kCIInputImageKey: overlay,
            kCIInputBackgroundImageKey: image
        ]
        
        guard let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: parametrs) else { fatalError() }
        
        guard let outputImage = filter.outputImage else { fatalError() }
        let cropRect = image.extent
        return outputImage.imageByCroppingToRect(cropRect)
    }
}


func colorOverlay(color: UIColor) -> Filter {
    return { image in
        let overlay = colorGenerator(color)(image)
        return compositeSourceOver(overlay)(image)
    }
}


let url = NSURL(string: "http://www.objc.io/images/covers/16.jpg")
let image = CIImage(contentsOfURL: url!)!


let blurRadius = 5.0
let overlayColor = UIColor.redColor().colorWithAlphaComponent(0.6)
let blurredImage = blur(blurRadius)(image)
let overlaidImage = colorOverlay(overlayColor)(blurredImage)



func composeFilters(filter1: Filter, _ filter2: Filter) -> Filter {
    return { image in filter2(filter1(image)) }
}

let myFilter1 = composeFilters(blur(blurRadius), colorOverlay(overlayColor))
let result = myFilter1(image)

infix operator >>> { associativity left }

func >>> (  lter1 : Filter ,  lter2 : Filter ) -> Filter {
    return { image in  lter2 (  lter1 (image))
    }
}

let myFilter2 = blur(blurRadius) >>> colorOverlay(overlayColor)
let result2 = myFilter2(image)






