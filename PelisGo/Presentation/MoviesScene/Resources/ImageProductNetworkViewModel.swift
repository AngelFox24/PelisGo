//
//  ImageProductNetworkViewModel.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 23/11/23.
//

import Foundation
import SwiftUI
import Combine
import ImageIO

class ImageProductNetworkViewModel: ObservableObject {
    @Published var imageProduct: Image?
    // Image("ProductoSinNombre")
    var suscriber = Set<AnyCancellable>()
    func getImage(id: String, url: URL, save: Bool) {
        if imageProduct != nil { // imagen ya cargada en memoria
            print("Imagen ya esta cargada para que quieres cargarlo pz")
            return
        } else {
            if let savedImage = loadSavedImage(id: id) {
                print("Se ha cargado desde local")
                imageProduct = Image(uiImage: savedImage)
            } else {
                URLSession.shared.dataTaskPublisher(for: url)
                    .tryMap { data, _ in
                        guard let image = UIImage(data: data) else {
                            throw URLError(.badServerResponse)
                        }
                        return image
                    }
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            print("Error al descargar la imagen: \(error)")
                        }
                    }, receiveValue: { image in
                        self.imageProduct = Image(uiImage: image)
                        if save {
                            if self.shouldSaveImage(image: image) {
                                print("La imagen es aceptada para ser guardada")
                                if self.saveImage(id: id, image: image, url: url.absoluteString) {
                                    } else {
                                        print("Error al guardar imagen, no se pudo reemplazar")
                                    }
                            }
                        }
                    })
                    .store(in: &suscriber)
            }
        }
    }
    func saveImage(id: String, image: UIImage, url: String) -> Bool {
        var savedImage = false
        guard let libraryDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first else {
            return false
        }
        let imagesDirectory = libraryDirectory.appendingPathComponent("Images")
        do {
            try FileManager.default.createDirectory(at: imagesDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error al crear el directorio de imágenes: \(error)")
            return false
        }
        let fileURL = imagesDirectory.appendingPathComponent(id + ".jpeg")
        if let data = image.jpegData(compressionQuality: 1.0) {
            do {
                // Guardar la imagen en el dispositivo
                try data.write(to: fileURL)
                savedImage = true
            } catch {
                print("Error al guardar la imagen: \(error)")
            }
        }
        return savedImage
    }
    
    func loadSavedImage(id: String) -> UIImage? {
        print("Se entro a verificar si hay imagen guarda")
        guard let libraryDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first else {
            return nil
        }
        let imagesDirectory = libraryDirectory.appendingPathComponent("Images")
        let fileURL = imagesDirectory.appendingPathComponent(id + ".jpeg")
        if let imageData = try? Data(contentsOf: fileURL) {
            print("Se obtuvo la imgen desde el dispositivo \(id)")
            print("Ruta de la imagen guardada: \(fileURL.path)")
            return UIImage(data: imageData)
        } else {
            print("No se pudo obtener la imagen \(id).jpeg")
        }
        return nil
    }
    func deleteImage(id: UUID) {
        guard let libraryDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first else {
            return
        }
        let imagesDirectory = libraryDirectory.appendingPathComponent("Images")
        let fileURL = imagesDirectory.appendingPathComponent(id.uuidString + ".jpeg")
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("Se eliminó la imagen con el ID \(id.uuidString)")
        } catch {
            print("Error al eliminar la imagen con el ID \(id.uuidString): \(error.localizedDescription)")
        }
    }
    func shouldSaveImage(image: UIImage) -> Bool {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return false
        }
        let imageSize = image.size
        let imageSizeInPixels = Int(imageSize.width) * Int(imageSize.height)
        let imageSizeInKB = imageData.count / 1024 // Divide entre 1024 para obtener el tamaño en KB
        let maximumImageSizeInPixels = 1920 * 1080 // Define el tamaño máximo permitido en píxeles
        let maximumImageSizeInKB = 1024 // Define el tamaño máximo permitido en KB
        if imageSizeInPixels > maximumImageSizeInPixels || imageSizeInKB > maximumImageSizeInKB {
            return false
        }
        print("La imagen es valida para ser guardada \(imageSizeInPixels.description) ----- \(imageSizeInKB.description)")
        return true
    }
}
