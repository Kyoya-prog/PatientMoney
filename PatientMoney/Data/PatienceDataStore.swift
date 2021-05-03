import FirebaseAuth
import FirebaseFirestore
import Foundation

class PatienceDataStore: PatienceRepository {
    func registerPatienceData(data: [String: Any]) -> Error? {
        var returningError: Error?
        firestore.collection("patience").addDocument(data: data) { error in
            returningError = error
        }
        return returningError
    }

    func fetchPatienceData(date: Date) -> Result<[PatienceRecord], Error> {
        let ref = firestore.collection("patience")
        let query = ref.whereField("uid", isEqualTo: FirebaseAuthManeger.shared.uid).whereField("Date", isEqualTo: date)
        var result: Result<[PatienceRecord], Error> = .failure(NSError())
        query.getDocuments { [ weak self ]querysnapshot, error in
            guard let self = self else { return }
            if let error = error {
                result = .failure(error)
            } else if let documents = querysnapshot?.documents {
                result = .success(self.createPatienceRecord(documents: documents))
            }
        }
        return result
    }

    func updatePatienceData(documentId: String, record: [String: Any]) -> Error? {
        let document = firestore.document(documentId)
        var returningError: Error?
        document.updateData(record) { error in
            returningError = error
        }
        return returningError
    }

    private let firestore = Firestore.firestore()

    private func createPatienceRecord(documents: [QueryDocumentSnapshot]) -> [PatienceRecord] {
        documents.map {
            PatienceRecord(documentID: $0.documentID,
                           date: ($0.data()["Date"] as? Date) ?? Date() ,
                           description: ($0.data()["Memo"] as? String) ?? "",
                           money: ($0.data()["Money"] as? Int) ?? 0,
                           categoryTitle: ( $0.data()["Categoy"] as? String) ?? ""  )
        }
    }
}
