// Copyright © 2022 JARMourato All rights reserved.

import CoreGraphics

extension CGPoint {
    /// Builds a point from an origin and a displacement
    public func displace(by point: CGPoint = .zero) -> CGPoint {
        CGPoint(x: self.x+point.x, y: self.y+point.y)
    }

    /// Caps the point to the unit space
    public func capped() -> CGPoint {
        CGPoint(x: max(min(x, 1), 0), y: max(min(y, 1), 0))
    }
}
