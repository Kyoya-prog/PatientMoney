import FirebaseAuth
import FirebaseFirestore
import Foundation

class RegisterDataStore: RegisterRepository {
    func registerPatienceData(data: [String: Any]) -> Error? {
        var returningError: Error?
        firestore.collection("patience").addDocument(data: data) { error in
            returningError = error
        }
        return returningError
    }

    private let firestore = Firestore.firestore()
}
