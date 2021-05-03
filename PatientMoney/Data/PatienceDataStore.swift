import FirebaseAuth
import FirebaseFirestore
import Foundation
import RxSwift

class PatienceDataStore: PatienceRepository {
    func registerPatienceData(data: [String: Any]) -> Error? {
        var returningError: Error?
        firestore.collection("patience").addDocument(data: data) { error in
            returningError = error
        }
        return returningError
    }

    func fetchPatienceData(date: Date) -> Single<[PatienceRecord]> {
        Single<[PatienceRecord]>.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create() }
            let ref = self.firestore.collection("patience")
            let query = ref.whereField("UID", isEqualTo: FirebaseAuthManeger.shared.uid)//.whereField("Date", isEqualTo: date)
            query.getDocuments { query, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                if let documents = query?.documents {
                    observer(.success(self.createPatienceRecord(documents: documents)))
                    return
                }
            }
            return Disposables.create()
        }
    }
    func updatePatienceData(documentId: String, record: [String: Any]) -> Error? {
        let document = firestore.collection("patience").document(documentId)
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
                           categoryTitle: ( $0.data()["Category"] as? String) ?? ""  )
        }
    }
}
