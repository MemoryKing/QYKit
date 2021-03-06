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
///网络请求
open class QYAlamofire: NSObject {
    private var isNet = false
    ///是否数据处理,默认false
    public var isDataManage: Bool = false
    ///超时时间,默认30秒
    public var timeOut: Double = 30.0
    ///请求头
    public var header: Dictionary<String, String>?
    ///编码
    public var encoding: ParameterEncoding = URLEncoding.default
    ///拦截器
    public var interceptor: RequestInterceptor?
    
    public var successCode: String = "1"
    ///数据获取参数,默认data
    public var data: String = "data"
    ///错误获取参数,默认msg
    public var msg: String = "msg"
    
    override init() {
        super.init()
        
    }
    
    ///配置请求参数
    open func yi_configureRequestParameters() { }
    
    ///获取当前网络状态
    func getNerworkingReachability(_ block: ((Bool)->())?) {
        let manager = NetworkReachabilityManager.init(host: "www.baidu.com")
        manager?.startListening(onUpdatePerforming: { (status) in
            switch status {
            case .notReachable:
                block?(false)
            case .unknown:
                block?(false)
            case .reachable(.cellular):
                block?(true)
            case .reachable(.ethernetOrWiFi):
                block?(true)
            }
        })
    }
    
}

public extension QYAlamofire {
    //MARK: --- get
    ///get
    final func get(_ api: String,_ parameters: [String: Any]? = nil,success: ((QYJSON)->())?,error: ErrorBlock) {
        
        yi_configureRequestParameters()
        var headers: HTTPHeaders?
        if let h = header {
            headers = HTTPHeaders(h)
        }
        getNerworkingReachability {
            if $0 {
                self.request(api, method: .get, parameters: parameters, encoding: self.encoding, headers: headers, interceptor: self.interceptor) { (result) in
                    let json = QYJSON.init(result)
                    
                    success?(json)
                } error: { (afError,data) in
                    self.errorMethod(afError, error,data)
                }
            } else {
                self.nerworkingError(error)
            }
        }
        
    }
    
    ///get
    final func get<T: QYCodable>(_ api: String,_ parameters: [String: Any]? = nil,success: ((T)->())?,error: ErrorBlock) {
        yi_configureRequestParameters()
        var headers: HTTPHeaders?
        if let h = header {
            headers = HTTPHeaders(h)
        }
        getNerworkingReachability {
            if $0 {
                self.request(api, method: .get, parameters: parameters, encoding: self.encoding, headers: headers, interceptor: self.interceptor) { (result) in
                    let json = QYJSON.init(result)
                    if let model = try? T(from: json[self.data].dictionaryObject) {
                        success?(model)
                    } else {
                        error?(json)
                    }
                } error: { (afError,data) in
                    self.errorMethod(afError, error,data)
                }
            } else {
                self.nerworkingError(error)
            }
        }
        
    }
    
    //MARK: --- post
    ///post
    final func post(_ api: String,_ parameters: [String: Any]? = nil,success: ((QYJSON)->())?,error: ErrorBlock) {
        yi_configureRequestParameters()
        var headers: HTTPHeaders?
        if let h = header {
            headers = HTTPHeaders(h)
        }
        getNerworkingReachability {
            if $0 {
                self.request(api, method: .post, parameters: parameters, encoding: self.encoding, headers: headers, interceptor: self.interceptor) { (result) in
                    let json = QYJSON.init(result)
                    success?(json)
                } error: { (afError,data) in
                    self.errorMethod(afError, error,data)
                }
            } else {
                self.nerworkingError(error)
            }
        }
        
    }
    ///post
    final func post<T:QYCodable>(_ api: String,_ parameters: [String: Any]? = nil,success: ((T)->())?,error: ErrorBlock) {
        yi_configureRequestParameters()
        var headers: HTTPHeaders?
        if let h = header {
            headers = HTTPHeaders(h)
        }
        getNerworkingReachability {
            if $0 {
                self.request(api, method: .post, parameters: parameters, encoding: self.encoding, headers: headers, interceptor: self.interceptor) { (result) in
                    let json = QYJSON.init(result)
                    if let model = try? T(from: json[self.data].dictionaryObject) {
                        success?(model)
                    } else {
                        var dic = [String: Any]()
                        dic["code"] = -77777
                        dic[self.msg] = "model转换失败"
                        error?(QYJSON.init(dic))
                    }
                } error: { (afError,data) in
                    self.errorMethod(afError, error,data)
                }
            } else {
                self.nerworkingError(error)
            }
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
        getNerworkingReachability {
            if $0 {
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
                }, to: api, usingThreshold: UInt64.init(), method: .post, headers: headers, interceptor: self.interceptor, fileManager: FileManager()) { (URLRequest) in
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
                            self.errorMethod(err, error,response.data)
                    }
                }
            } else {
                self.nerworkingError(error)
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
        
        getNerworkingReachability({
            if $0 {
                AF.upload(multipartFormData: multipartFormData, to: api, usingThreshold: UInt64.init(), method: .post, headers: headers, interceptor: self.interceptor, fileManager: FileManager()) { (URLRequest) in
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
                            self.errorMethod(err, error,response.data)
                    }
                }
            } else {
                self.nerworkingError(error)
            }
        })
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
                       error: ((AFError,Data?)->())?) {
        
        AF.request(convertible, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: interceptor) { (URLRequest) in
            ///超时时间
            URLRequest.timeoutInterval = self.timeOut
            
        }.responseJSON { response in
            
            switch response.result {
                case .success(let result):
                    success?(result)
                    
                case .failure(let err):
                    error?(err,response.data)
            }
        }
    }
    
    //MARK: --- 错误处理
    ///返回错误处理
    func errorMethod(_ afError: AFError,_ errorB: ErrorBlock,_ data:Data?) {
        var dec : String?
        switch afError._code {
        case 13: dec = "请求超时"
        case -1009: dec = "网络异常,请检查网络后重试"
        default:
            dec = data?.yi_toEncodingString()
        }
        var dic = [String: Any]()
        dic["code"] = afError._code
        dic[self.msg] = dec
        errorB?(QYJSON.init(dic))
    }
    ///网络错误处理
    func nerworkingError(_ errorB: ErrorBlock) {
        var dic = [String: Any]()
        dic["code"] = -99999
        dic[self.msg] = "网络异常,请检查网络后重试"
        errorB?(QYJSON.init(dic))
    }
}


