/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 *******************************************************************************/


import Foundation
import Alamofire

public protocol QYAlamofireProtocol {

}
public enum QYUploadFileWay {
    ///图片
    case image
    ///路径
    case path
}

public typealias ErrorBlock = ((QYJSON)->())?
private let QYF = QYAlamofire.shared
///网络请求
open class QYAlamofire {
    static var shared = QYAlamofire()
    ///是否数据处理,默认false
    var isDataManage: Bool = false
    ///超时时间,默认30秒
    var timeOut: Double = 30.0
    ///请求头
    var header: Dictionary<String, String>?
    ///编码
    var encoding: ParameterEncoding = URLEncoding.default
    ///拦截器
    var interceptor: RequestInterceptor?
    
    var successCode: String = "1"
    ///数据获取参数,默认data
    var data: String = "data"
    ///错误获取参数,默认msg
    var msg: String = "msg"
    ///配置请求参数
    public func yi_configureRequestParameters() {


    }
}

public extension QYAlamofire {
    //MARK: --- get
    ///get
    final func get(_ api: String,_ parameters: [String: Any]? = nil,success: ((QYJSON)->())?,error: ErrorBlock) {
        var headers: HTTPHeaders?
        if let h = header {
            headers = HTTPHeaders(h)
        }
        request(api, method: .get, parameters: parameters, encoding: encoding, headers: headers, interceptor: interceptor) { (result) in
            let json = QYJSON.init(result)
            
            success?(json)
        } error: { (afError) in
            self.errorMethod(afError, error)
        }
    }
    
    ///get
    final func get<T: QYCodable>(_ api: String,_ parameters: [String: Any]? = nil,success: ((T)->())?,error: ErrorBlock) {
        var headers: HTTPHeaders?
        if let h = header {
            headers = HTTPHeaders(h)
        }
        request(api, method: .get, parameters: parameters, encoding: encoding, headers: headers, interceptor: interceptor) { (result) in
            let json = QYJSON.init(result)
            if let model = try? T(from: json[self.data].dictionaryObject) {
                success?(model)
            } else {
                error?(json)
            }
        } error: { (afError) in
            self.errorMethod(afError, error)
        }
    }
    
    //MARK: --- post
    ///post
    final func post(_ api: String,_ parameters: [String: Any]? = nil,success: ((QYJSON)->())?,error: ErrorBlock) {
        
        var headers: HTTPHeaders?
        if let h = header {
            headers = HTTPHeaders(h)
        }
        request(api, method: .post, parameters: parameters, encoding: encoding, headers: headers, interceptor: interceptor) { (result) in
            let json = QYJSON.init(result)
            success?(json)
        } error: { (afError) in
            self.errorMethod(afError, error)
        }
    }
    ///post
    final func post<T:QYCodable>(_ api: String,_ parameters: [String: Any]? = nil,success: ((T)->())?,error: ErrorBlock) {
        
        var headers: HTTPHeaders?
        if let h = header {
            headers = HTTPHeaders(h)
        }
        request(api, method: .post, parameters: parameters, encoding: encoding, headers: headers, interceptor: interceptor) { (result) in
            let json = QYJSON.init(result)
            if let model = try? T(from: json[self.data].dictionaryObject) {
                success?(model)
            } else {
                error?(json)
            }
        } error: { (afError) in
            self.errorMethod(afError, error)
        }
    }
    
    //MARK: --- 上传图片文件
    /// 上传图片文件
    /// - Parameters:
    ///   - api: 地址
    ///   - parameters: 参数
    ///   - fileParam: 文件参数
    ///   - files: 文件数组---->image,path,data
    ///   - progressHandler: 进度
    final func uploadImage(_ api: String,_ parameters: [String: Any]? = nil,
                           fileParam: String,files: [Any],
                           progressHandler: ((Progress) -> ())? = nil,
                           success: ((QYJSON)->())?,error: ErrorBlock) {
        var headers: HTTPHeaders?
        if let h = header {
            headers = HTTPHeaders(h)
        }
        AF.upload(multipartFormData: { multipartFormData in
            for file in files {
                switch file {
                    case let image as UIImage:
                        if let data = image.pngData() {
                            multipartFormData.append(data, withName: fileParam, fileName: Date().yi_toString() + ".jpg", mimeType: "image/jpg/png/jpeg")
                        }
                    case let data as Data:
                        multipartFormData.append(data, withName: fileParam, fileName: Date().yi_toString() + ".jpg", mimeType: "image/jpg/png/jpeg")
                    case let path as String:
                        if let url = URL.init(string: path) {
                            multipartFormData.append(url, withName: fileParam, fileName: Date().yi_toString() + ".jpg", mimeType: "image/jpg/png/jpeg")
                        }
                    default:
                        break
                }
                
            }
            if let params = parameters {
                for key in params.keys {
                    if key == fileParam { break }
                    if let value = params[key] as? String, let data = value.yi_toData() {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }
        }, to: api, usingThreshold: UInt64.init(), method: .post, headers: headers, interceptor: interceptor, fileManager: FileManager()) { (URLRequest) in
            ///超时时间
            URLRequest.timeoutInterval = self.timeOut
        }.uploadProgress { (progress) in
            if let b = progressHandler {
                b(progress)
            }
        }.responseJSON { (response) in
            switch response.result {
                case .success(let result):
                    let json = QYJSON.init(result)
                    success?(json)
                case .failure(let err):
                    self.errorMethod(err, error)
            }
        }
    }
    
    /// 上传图片文件
    /// - Parameters:
    ///   - api: 地址
    ///   - multipartFormData: 设置参数
    ///   - progressHandler: 进度
    final func uploadImage(_ api: String,
                           multipartFormData:@escaping ((MultipartFormData)->()),
                           progressHandler: ((Progress) -> ())? = nil,
                           success: ((QYJSON)->())?,error: ErrorBlock) {
        var headers: HTTPHeaders?
        if let h = header {
            headers = HTTPHeaders(h)
        }
        AF.upload(multipartFormData: multipartFormData, to: api, usingThreshold: UInt64.init(), method: .post, headers: headers, interceptor: interceptor, fileManager: FileManager()) { (URLRequest) in
            ///超时时间
            URLRequest.timeoutInterval = self.timeOut
        }.uploadProgress { (progress) in
            if let b = progressHandler {
                b(progress)
            }
        }.responseJSON { (response) in
            switch response.result {
                case .success(let result):
                    let json = QYJSON.init(result)
                    success?(json)
                case .failure(let err):
                    self.errorMethod(err, error)
            }
        }
    }
    
    /// 通用请求
    /// - Parameters:
    ///   - convertible: 地址
    ///   - method: 方式
    ///   - parameters: 参数
    ///   - headers: 头部
    ///   - encoding: 编码
    ///   - interceptor: 拦截器
    ///   - successB: 成功返回
    ///   - errorB: 失败返回
    final func request(_ convertible: URLConvertible,
                       method: HTTPMethod ,
                       parameters: Parameters? = nil,
                       encoding: ParameterEncoding = URLEncoding.default,
                       headers: HTTPHeaders? = nil,
                       interceptor: RequestInterceptor? = nil,
                       success: ((Any)->())?,
                       error: ((AFError)->())?) {
        yi_configureRequestParameters()
        AF.request(convertible, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: interceptor) { (URLRequest) in
            ///超时时间
            URLRequest.timeoutInterval = self.timeOut
            
        }.responseJSON { response in
            
            switch response.result {
                case .success(let result):
                    success?(result)
                    
                case .failure(let err):
                    error?(err)
            }
        }
    }
    
    //MARK: --- 错误处理
    ///错误处理
    func errorMethod(_ afError: AFError,_ errorB: ErrorBlock) {
        var dec : String?
        switch afError._code {
            case 13: dec = "请求超时"
                
            default:
                dec = afError.errorDescription
        }
        var dic = [String: Any]()
        dic["code"] = afError._code
        dic[self.msg] = dec
        errorB?(QYJSON.init(dic))
    }
}


