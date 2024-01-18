//
//  SpotifyPlayer.swift
//  Autolayout
//
//  Created by Mustafa Bekirov on 16.01.2024.
//

import UIKit

class SpotifyPlayer: UIViewController {
    
    let buttonHeight: CGFloat = 40

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        let albumImage = makeImageView(named: "rush")
        let trackLabel = makeTrackLabel(withText: "Silvester")
        let albumLabel = makeAlbumLabel(withText: "Meow • Cat")

        let playButton = makePlayButton()
        let previewStartLabel = makePreviewLabel(withText: "0:00")
        let previewEndLabel = makePreviewLabel(withText: "0:30")
        let progressView = makeProgressView()

        let spotifyButton = makeSpotifyButton(withText: "PLAY ON SPOTIFY")

        view.addSubview(albumImage)
        view.addSubview(trackLabel)
        view.addSubview(albumLabel)

        view.addSubview(playButton)
        view.addSubview(previewStartLabel)
        view.addSubview(progressView)
        view.addSubview(previewEndLabel)

        view.addSubview(spotifyButton)

        albumImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        albumImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumImage.heightAnchor.constraint(equalTo: albumImage.widthAnchor, multiplier: 1).isActive = true
        albumImage.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true

        trackLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 8).isActive = true
        trackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        trackLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true

        albumLabel.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 8).isActive = true
        albumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        albumLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true

        playButton.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: 8).isActive = true
        playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: buttonHeight).isActive = true

        previewStartLabel.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        previewStartLabel.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 8).isActive = true

        progressView.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        progressView.leadingAnchor.constraint(equalTo: previewStartLabel.trailingAnchor, constant: 8).isActive = true

        previewEndLabel.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        previewEndLabel.leadingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 8).isActive = true
        previewEndLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true

        spotifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spotifyButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 32).isActive = true
        spotifyButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true

        spotifyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        spotifyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        // spotifyButton.heightAnchor we need to set to get our nice rounded corners - height is fixed
        // spotifyButton.widthAnchor we don't need to set because the intrinsic content size and insets are enough - width is dynamic
    }

    public func makeImageView(named: String) -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: named)

        // Stretch and grow
        view.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)

        return view
    }

    func makeTrackLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)

        return label
    }

    func makeAlbumLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray

        return label
    }

    func makePlayButton() -> UIButton {
        let image = UIImage(systemName: "play") as UIImage?

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)

        return button
    }

    func makePreviewLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)

        return label
    }

    func makeProgressView() -> UIProgressView {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.tintColor = .gray

        return progressView
    }

    func makeSpotifyButton(withText title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .darkGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonHeight / 2
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: buttonHeight, bottom: 10, right: buttonHeight)

        let attributedText = NSMutableAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: 1
        ])

        button.setAttributedTitle(attributedText, for: .normal)

        return button
    }
}

