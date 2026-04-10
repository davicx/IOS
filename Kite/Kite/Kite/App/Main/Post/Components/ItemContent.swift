//
//  ItemContent.swift
//  Kite
//
//  Created by David Vasquez on 4/6/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS


final class ItemContent: UIView {

    //UI COMPONENTS — regions
    private let itemHeader = UIView()
    private let itemBody = UIView()
    private let itemFooter = UIView()

    //UI COMPONENTS — body
    private let itemImageView = UIView()
    private let itemImageContentView = UIImageView()
    private let itemInfoView = UIView()
    private let itemPurchasedView = UIView()

    //UI COMPONENTS — footer
    private let itemCaptionView = UIView()
    
    //Sizing
    private let imageWellCornerRadius: CGFloat = 6

    //Inset image rect uses a slightly smaller radius so the clip stays concentric with the outer well.
    private var imageWellInnerClipCornerRadius: CGFloat {
        max(0, imageWellCornerRadius - itemImageMargin)
    }

    private let itemHeaderHeight: CGFloat = 8
    private let itemBodyHeight: CGFloat = 280
    private let itemFooterMinHeight: CGFloat = 40
    private let purchasedRowHeight: CGFloat = 60
    private let itemImageMargin: CGFloat = 6

    
    private var topRowHeight: CGFloat {
        itemBodyHeight - purchasedRowHeight
    }

    
    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        // Must be false so the image well’s layer shadow isn’t clipped; subviews stay edge-aligned.
        clipsToBounds = false
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let b = itemImageView.bounds
        guard b.width > 0, b.height > 0 else { return }
        itemImageView.layer.shadowPath = UIBezierPath(roundedRect: b, cornerRadius: imageWellCornerRadius).cgPath
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Total height = header + body + footer (footer at least min height before caption content is measured).
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: itemHeaderHeight + itemBodyHeight + itemFooterMinHeight)
    }

    private func setupViews() {
        setupHeader()
        setupBody()
        setupFooter()
    }

    //HEADER: A slim header with the menu icon in it
    private func setupHeader() {
        itemHeader.translatesAutoresizingMaskIntoConstraints = false
        itemHeader.clipsToBounds = true
        itemHeader.backgroundColor = .red // temp — region debug
        addSubview(itemHeader)

        NSLayoutConstraint.activate([
            itemHeader.topAnchor.constraint(equalTo: topAnchor),
            itemHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemHeader.heightAnchor.constraint(equalToConstant: itemHeaderHeight)
        ])
    }


    //BODY: Contains all Item information and Purchase button
    private func setupBody() {
        itemBody.translatesAutoresizingMaskIntoConstraints = false
        itemBody.clipsToBounds = true
        itemBody.backgroundColor = .orange // temp
        addSubview(itemBody)

        NSLayoutConstraint.activate([
            itemBody.topAnchor.constraint(equalTo: itemHeader.bottomAnchor),
            itemBody.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemBody.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemBody.heightAnchor.constraint(equalToConstant: itemBodyHeight)
        ])

        setupItemImageView()
        setupItemInfoView()
        setupItemPurchasedView()
    }
    
    //Body: Setup the image on the left side
    private func setupItemImageView() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.clipsToBounds = false
        itemImageView.backgroundColor = .systemGray4 // temp — well behind image
        itemImageView.layer.cornerRadius = imageWellCornerRadius
        if #available(iOS 13.0, *) {
            itemImageView.layer.cornerCurve = .continuous
        }
        itemImageView.layer.shadowColor = UIColor.black.cgColor
        itemImageView.layer.shadowOpacity = 0.1
        itemImageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        itemImageView.layer.shadowRadius = 4
        itemImageView.layer.masksToBounds = false
        itemBody.addSubview(itemImageView)

        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: itemBody.leadingAnchor),
            itemImageView.topAnchor.constraint(equalTo: itemBody.topAnchor),
            itemImageView.widthAnchor.constraint(equalTo: itemBody.widthAnchor, multiplier: 0.4),
            itemImageView.heightAnchor.constraint(equalToConstant: topRowHeight)
        ])

        itemImageContentView.translatesAutoresizingMaskIntoConstraints = false
        itemImageContentView.clipsToBounds = true
        itemImageContentView.layer.cornerRadius = imageWellInnerClipCornerRadius
        if #available(iOS 13.0, *) {
            itemImageContentView.layer.cornerCurve = .continuous
        }
        itemImageContentView.contentMode = .scaleAspectFill
        itemImageContentView.backgroundColor = .clear
        itemImageContentView.image = UIImage(named: "background_1")
        itemImageView.addSubview(itemImageContentView)

        NSLayoutConstraint.activate([
            itemImageContentView.leadingAnchor.constraint(equalTo: itemImageView.leadingAnchor, constant: itemImageMargin),
            itemImageContentView.topAnchor.constraint(equalTo: itemImageView.topAnchor, constant: itemImageMargin),
            itemImageContentView.trailingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: -itemImageMargin),
            itemImageContentView.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: -itemImageMargin)
        ])
    }

    //Body: Setup the item info on the right side
    private func setupItemInfoView() {
        itemInfoView.translatesAutoresizingMaskIntoConstraints = false
        itemInfoView.clipsToBounds = true
        itemInfoView.backgroundColor = .green // temp
        itemBody.addSubview(itemInfoView)

        NSLayoutConstraint.activate([
            itemInfoView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor),
            itemInfoView.trailingAnchor.constraint(equalTo: itemBody.trailingAnchor),
            itemInfoView.topAnchor.constraint(equalTo: itemBody.topAnchor),
            itemInfoView.heightAnchor.constraint(equalToConstant: topRowHeight)
        ])
    }
    
    //Body: Setup the purchased bar full width on bottom with purchased button and status
    private func setupItemPurchasedView() {
        itemPurchasedView.translatesAutoresizingMaskIntoConstraints = false
        itemPurchasedView.clipsToBounds = true
        itemPurchasedView.backgroundColor = .blue // temp
        itemBody.addSubview(itemPurchasedView)

        NSLayoutConstraint.activate([
            itemPurchasedView.leadingAnchor.constraint(equalTo: itemBody.leadingAnchor),
            itemPurchasedView.trailingAnchor.constraint(equalTo: itemBody.trailingAnchor),
            itemPurchasedView.topAnchor.constraint(equalTo: itemImageView.bottomAnchor),
            itemPurchasedView.heightAnchor.constraint(equalToConstant: purchasedRowHeight)
        ])
    }

    //FOOTER: Contains Post Caption
    private func setupFooter() {
        itemFooter.translatesAutoresizingMaskIntoConstraints = false
        itemFooter.clipsToBounds = true
        itemFooter.backgroundColor = .purple // temp
        itemFooter.setContentHuggingPriority(.defaultLow, for: .vertical)
        itemFooter.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        addSubview(itemFooter)

        NSLayoutConstraint.activate([
            itemFooter.topAnchor.constraint(equalTo: itemBody.bottomAnchor),
            itemFooter.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemFooter.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemFooter.bottomAnchor.constraint(equalTo: bottomAnchor),
            itemFooter.heightAnchor.constraint(greaterThanOrEqualToConstant: itemFooterMinHeight)
        ])

        setupItemCaptionView()
    }

    private func setupItemCaptionView() {
        itemCaptionView.translatesAutoresizingMaskIntoConstraints = false
        itemCaptionView.clipsToBounds = true
        itemCaptionView.backgroundColor = .systemPink // temp
        itemCaptionView.setContentCompressionResistancePriority(.required, for: .vertical)
        itemFooter.addSubview(itemCaptionView)

        NSLayoutConstraint.activate([
            itemCaptionView.topAnchor.constraint(equalTo: itemFooter.topAnchor),
            itemCaptionView.leadingAnchor.constraint(equalTo: itemFooter.leadingAnchor),
            itemCaptionView.trailingAnchor.constraint(equalTo: itemFooter.trailingAnchor),
            itemCaptionView.bottomAnchor.constraint(equalTo: itemFooter.bottomAnchor)
        ])
    }
}
