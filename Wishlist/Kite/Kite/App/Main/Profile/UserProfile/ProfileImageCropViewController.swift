//
//  ProfileImageCropViewController.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class ProfileImageCropViewController: UIViewController, UIScrollViewDelegate {

    //LOGIC
    var onUsePhoto: ((UIImage) -> Void)?
    private let sourceImage: UIImage
    private var didConfigureZoom = false
    private var isConfirming = false
    private let outputSide: CGFloat = 512
    private let maxCropSide: CGFloat = 300
    private let cropInset: CGFloat = 24

    //UI COMPONENTS
    private let topBar = UIView()
    private let cancelButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let usePhotoButton = UIButton(type: .system)
    private let workspace = CropTouchView()
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let maskView = CropMaskView()
    private let instructionLabel = UILabel()

    //MANAGE VIEWS
    init(image: UIImage) {
        sourceImage = image.normalizedUp()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#111111")
        setupViews()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let crop = cropSquare(in: workspace.bounds)
        guard crop.width > 1 else { return }
        let sideChanged = abs(scrollView.bounds.width - crop.width) > 0.5
        scrollView.frame = crop
        maskView.frame = workspace.bounds
        maskView.show(cropRect: crop)
        if !didConfigureZoom || (sideChanged && scrollView.zoomScale <= 1.01) {
            didConfigureZoom = true
            applyInitialZoom()
        }
    }

    //LAYOUT and UI
    private func setupViews() {
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)

        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        topBar.addSubview(cancelButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Edit Photo"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textAlignment = .center
        topBar.addSubview(titleLabel)

        usePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        usePhotoButton.setTitle("Use Photo", for: .normal)
        usePhotoButton.setTitleColor(Colors.primaryPink, for: .normal)
        usePhotoButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        usePhotoButton.addTarget(self, action: #selector(usePhotoTapped), for: .touchUpInside)
        topBar.addSubview(usePhotoButton)

        workspace.translatesAutoresizingMaskIntoConstraints = false
        workspace.clipsToBounds = true
        workspace.scrollView = scrollView
        view.addSubview(workspace)

        scrollView.delegate = self
        scrollView.clipsToBounds = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.bouncesZoom = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .clear
        workspace.addSubview(scrollView)

        imageView.image = sourceImage
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        scrollView.addSubview(imageView)

        maskView.isUserInteractionEnabled = false
        maskView.backgroundColor = .clear
        workspace.addSubview(maskView)

        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.text = "Move and scale"
        instructionLabel.textColor = UIColor.white.withAlphaComponent(0.85)
        instructionLabel.font = .systemFont(ofSize: 14)
        instructionLabel.textAlignment = .center
        view.addSubview(instructionLabel)

        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 56),

            cancelButton.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 20),
            cancelButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),

            usePhotoButton.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -20),
            usePhotoButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),

            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instructionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),

            workspace.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            workspace.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            workspace.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            workspace.bottomAnchor.constraint(equalTo: instructionLabel.topAnchor, constant: -12)
        ])
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }

    //ACTIONS
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }

    @objc private func usePhotoTapped() {
        guard !isConfirming else { return }
        isConfirming = true
        usePhotoButton.isEnabled = false
        let cropped = croppedImage()
        onUsePhoto?(cropped)
        dismiss(animated: true)
    }

    //FUNCTIONS
    private func cropSquare(in bounds: CGRect) -> CGRect {
        let side = min(maxCropSide, bounds.width - cropInset * 2, bounds.height - cropInset * 2)
        guard side > 1 else { return .zero }
        return CGRect(
            x: bounds.midX - side / 2,
            y: bounds.midY - side / 2,
            width: side,
            height: side
        )
    }

    private func applyInitialZoom() {
        let imageSize = sourceImage.size
        let cropSide = scrollView.bounds.width
        guard imageSize.width > 0, imageSize.height > 0, cropSide > 0 else { return }

        let scale = max(cropSide / imageSize.width, cropSide / imageSize.height)
        let displaySize = CGSize(width: imageSize.width * scale, height: imageSize.height * scale)
        imageView.frame = CGRect(origin: .zero, size: displaySize)
        scrollView.contentSize = displaySize
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
        scrollView.zoomScale = 1
        scrollView.contentOffset = CGPoint(
            x: max(0, (displaySize.width - cropSide) / 2),
            y: max(0, (displaySize.height - cropSide) / 2)
        )
    }

    private func croppedImage() -> UIImage {
        let image = sourceImage
        guard let cgImage = image.cgImage,
              imageView.bounds.width > 0,
              imageView.bounds.height > 0 else {
            return image
        }

        let visible = scrollView.convert(scrollView.bounds, to: imageView)
        let pixelWidth = CGFloat(cgImage.width)
        let pixelHeight = CGFloat(cgImage.height)
        let scaleX = pixelWidth / imageView.bounds.width
        let scaleY = pixelHeight / imageView.bounds.height

        var crop = CGRect(
            x: visible.origin.x * scaleX,
            y: visible.origin.y * scaleY,
            width: visible.width * scaleX,
            height: visible.height * scaleY
        )
        let imageBounds = CGRect(x: 0, y: 0, width: pixelWidth, height: pixelHeight)
        crop = crop.intersection(imageBounds)
        let side = floor(min(crop.width, crop.height))
        guard side >= 1 else { return image }
        crop = CGRect(x: floor(crop.midX - side / 2), y: floor(crop.midY - side / 2), width: side, height: side)
        crop = crop.intersection(imageBounds)
        guard let croppedCG = cgImage.cropping(to: crop) else { return image }

        let square = UIImage(cgImage: croppedCG, scale: 1, orientation: .up)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.opaque = true
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: outputSide, height: outputSide), format: format)
        return renderer.image { _ in
            square.draw(in: CGRect(x: 0, y: 0, width: outputSide, height: outputSide))
        }
    }
}

private final class CropTouchView: UIView {
    weak var scrollView: UIScrollView?

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard bounds.contains(point), let scrollView else { return nil }
        return scrollView
    }
}

private final class CropMaskView: UIView {
    private let dimLayer = CAShapeLayer()
    private let borderLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        dimLayer.fillRule = .evenOdd
        dimLayer.fillColor = UIColor.black.withAlphaComponent(0.60).cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.white.withAlphaComponent(0.75).cgColor
        borderLayer.lineWidth = 1
        layer.addSublayer(dimLayer)
        layer.addSublayer(borderLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(cropRect: CGRect) {
        let path = UIBezierPath(rect: bounds)
        path.append(UIBezierPath(ovalIn: cropRect))
        dimLayer.frame = bounds
        dimLayer.path = path.cgPath
        borderLayer.frame = bounds
        borderLayer.path = UIBezierPath(ovalIn: cropRect).cgPath
    }
}

private extension UIImage {
    func normalizedUp() -> UIImage {
        guard imageOrientation != .up else { return self }
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.opaque = true
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        return renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
