
import Foundation

class AppServices
{
    
    
    class func getRequest( urlString: String, successBlock :@escaping (_ response :AnyObject)->Void, errorBlock:@escaping (_ errorMessage :String)->Void
        )
    {
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            
            DispatchQueue.main.async {
                
                if(error == nil)
                {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? AnyObject
                        guard let _ = responseJSON else {
                            errorBlock("Some error has been occurred!")
                            return
                        }
                        
                        successBlock(responseJSON!)
                    
                    }
                    catch
                    {
                        errorBlock("Some error has been occurred!")
                    }
                }
                else
                {
                    errorBlock(error!.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
    
}
