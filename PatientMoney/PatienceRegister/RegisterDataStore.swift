import FirebaseAuth
import FirebaseFirestore
import Foundation

class RegisterDataStore: RegisterRepository {
    init() {
        firestore = Firestore.firestore()
    }

    func registerPatienceData(date: Date, description: String, money: Int, category: String) -> Error? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        let documentData = ["Date": date, "Memo": description, "Money": money, "Category": category, "UID": uid] as [String: Any]
        var returningError: Error?
        firestore.collection("patience").document("patience").setData(documentData) { error in
            returningError = error
        }
        return returningError
    }

    private let firestore: Firestore
}
