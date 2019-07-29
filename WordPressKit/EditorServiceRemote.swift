import Foundation
import WordPressShared

public class EditorServiceRemote: ServiceRemoteWordPressComREST {
    public func postDesignateMobileEditor(_ siteID: Int, editor: EditorSettings.Mobile, success: @escaping (EditorSettings) -> Void, failure: @escaping (Error) -> Void) {
        let endpoint = "sites/\(siteID)/gutenberg?platform=mobile&editor=\(editor.rawValue)"
        let path = self.path(forEndpoint: endpoint, withVersion: ._2_0)

        wordPressComRestApi.POST(path, parameters: nil, success: { (responseObject, httpResponse) in
            do {
                let settings = try EditorSettings(with: responseObject)
                success(settings)
            } catch {
                failure(error)
            }
        }) { (error, httpError) in
            failure(error)
        }
    }

    public func getEditorSettings(_ siteID: Int, success: @escaping (EditorSettings) -> Void, failure: @escaping (Error) -> Void) {
        let endpoint = "sites/\(siteID)/gutenberg"
        let path = self.path(forEndpoint: endpoint, withVersion: ._2_0)

        wordPressComRestApi.GET(path, parameters: nil, success: { (responseObject, httpResponse) in
            do {
                let settings = try EditorSettings(with: responseObject)
                success(settings)
            } catch {
                failure(error)
            }
        }) { (error, httpError) in
            failure(error)
        }
    }
}
