import FirebaseAuth
import FirebaseFirestore
import Foundation
import RxSwift

class PatienceDataStore: PatienceRepository {
    func registerPatienceData(data: [String: Any]) -> Error? {
        var returningError: Error?
        firestoreCollectionReference.addDocument(data: data) { error in
            returningError = error
        }
        return returningError
    }

    func fetchPatienceData(date: Date) -> Single<[PatienceEntity]> {
        Single<[PatienceEntity]>.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create() }
                let query = self.firestoreCollectionReference.whereField("UID", isEqualTo: FirebaseAuthManeger.shared.uid).whereField("Date", isEqualTo: date)
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
        let document = firestoreCollectionReference.document(documentId)
        var returningError: Error?
        document.updateData(record) { error in
            returningError = error
        }
        return returningError
    }

    private func createPatienceRecord(documents: [QueryDocumentSnapshot]) -> [PatienceEntity] {
        documents.map {
            PatienceEntity(documentID: $0.documentID,
                           date: ($0.data()["Date"] as? Date) ?? Date() ,
                           memo: ($0.data()["Memo"] as? String) ?? "",
                           money: ($0.data()["Money"] as? Int) ?? 0,
                           categoryTitle: ( $0.data()["Category"] as? String) ?? ""  )
        }
    }

    private let firestoreCollectionReference = Firestore.firestore().collection("patience")
}
