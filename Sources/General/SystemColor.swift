// Copyright © 2022 JARMourato All rights reserved.

#if os(OSX)
import AppKit
public typealias SystemColor = NSColor
public typealias SystemView = NSView
#else
import UIKit
public typealias SystemColor = UIColor
public typealias SystemView = UIView
#endif
