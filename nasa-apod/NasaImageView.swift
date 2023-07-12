import SwiftUI

struct NASAImageView: View {
    @State private var imageURL: String = ""

    var body: some View {
        VStack {
            if !imageURL.isEmpty {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Text("Loading...")
                    .padding()
            }
        }
        .onAppear {
            fetchImageURL()
        }
    }

    func fetchImageURL() {
        let apiKey = "Fbc6i3XjnJIJcmQSZzwaMfojz9A5DIgQXJBbIIZE" // Replace with your own NASA APOD API key
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)"

        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(APODResponse.self, from: data)
                        DispatchQueue.main.async {
                            imageURL = result.url
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            .resume()
        }
    }
}

struct APODResponse: Codable {
    let url: String
}

struct NASAImageView_Previews: PreviewProvider {
    static var previews: some View {
        NASAImageView()
    }
}
