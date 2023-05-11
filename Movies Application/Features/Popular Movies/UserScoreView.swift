//
//  Copyright © Modus Create. All rights reserved.
//

import SwiftUI

struct UserScoreView: View {

	var progress: CGFloat
	var boxSize: CGFloat

	var body: some View {
		VStack {
			Group {
				ZStack {
					Circle()
						.frame(width: boxSize + 20, height: boxSize + 20)
						.foregroundColor(Color(red: 11 / 255, green: 37 / 255, blue: 63 / 255))

					Text("\(Int(progress * 10))%")
						.font(.system(Font.TextStyle.subheadline, design: Font.Design.rounded))
						.bold()
						.foregroundColor(.white)


					Circle()
						.stroke(Color(.systemGray5), lineWidth: 10)
						.frame(width: boxSize, height: boxSize)

					Circle()
						.trim(from: 0, to: progress / 10)
						.stroke(Color.green, lineWidth: 10)
						.frame(width: boxSize, height: boxSize)
						.rotationEffect(Angle(degrees: -90))
				}
			}
		}
	}
}

struct UserScoreView_Previews: PreviewProvider {
	static var previews: some View {
		UserScoreView(progress: 9.5, boxSize: 100)
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.dark)
	}
}
