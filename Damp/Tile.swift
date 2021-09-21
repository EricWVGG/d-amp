//
//  Tile.swift
//  Tile
//
//  Created by Eric Jacobsen on 9/20/21.
//

import SwiftUI


struct TileSymbol: View {
    var tileRed = SwiftUI.Color(red: 215/255, green: 50/255, blue: 70/255)

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                let height = width

                path.addLines([
                    CGPoint(x: 0, y: 0),
                    CGPoint(x: width * 0.5, y: 0),
                    CGPoint(x: 0, y: height * 0.5),
                    CGPoint(x: 0, y: 0)
                ])
            }
            .fill(tileRed)

            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                let height = width

                path.addLines([
                    CGPoint(x: width, y: 0),
                    CGPoint(x: 0, y: height),
                    CGPoint(x: width * 0.5, y: height),
                    CGPoint(x: width, y: height * 0.5),
                    CGPoint(x: width, y: 0)
                ])
            }
            .fill(tileRed)
        }
    }
}

struct BadgeSymbol_Previews: PreviewProvider {
    static var previews: some View {
        TileSymbol()
    }
}
