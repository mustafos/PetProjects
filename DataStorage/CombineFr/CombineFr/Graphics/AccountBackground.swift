//
//  AccountBackground.swift
//  CombineFr
//
//  Created by Mustafa Bekirov on 05.04.2023.
//

import SwiftUI

struct AccountBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                            gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.26374226808547974, green: 0.08583337068557739, blue: 0.8583333492279053, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.5648985505104065, green: 0.4633854031562805, blue: 0.9041666388511658, alpha: 1)), location: 1)]),
                            startPoint: UnitPoint(x: 0.5002250180369464, y: 3.093169944380636e-7),
                            endPoint: UnitPoint(x: -0.0016390738112972425, y: 0.9770852606178854)).ignoresSafeArea()
            .frame(height: 1704)
                .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: -100)
        
            RadialGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.5333333611488342, green: 0, blue: 0.33219045400619507, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.6470588445663452, green: 0.9203922152519226, blue: 0.9803921580314636, alpha: 1)), location: 0.9780701994895935)]),
                        center: UnitPoint(x: 0.7563192862964506, y: 0.669322815370287),
                        startRadius: 2.65010571053284,
                        endRadius: 206.687772225015
                      ).opacity(0.3)
        .frame(width: 1446.48, height: 1090.65)
        .mask(ShapeBG1())
        .offset(x: 220, y: -320)
            
            RadialGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.5333333611488342, green: 0, blue: 0.33219045400619507, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.6470588445663452, green: 0.9203922152519226, blue: 0.9803921580314636, alpha: 1)), location: 0.9780701994895935)]),
                        center: UnitPoint(x: 0.7563192677178399, y: 0.6693227594949087),
                        startRadius: 2.024239470445621,
                        endRadius: 173.3103691113065
                      )
            .blur(radius: 70)
            .frame(width: 697.56, height: 785.5)
             .mask(ShapeBG2())
             .offset(x: 40, y: -430)
            .blur(radius: 30)
            
            Bubble01()
                .fill(LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.3099882007, green: 0.2201374471, blue: 0.8097378612, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.2755598724, green: 0.544380486, blue: 0.8548029661, alpha: 1)), location: 0.2427859902381897),
                    .init(color: Color(#colorLiteral(red: 0.2676272094, green: 0.5205127597, blue: 0.8518123031, alpha: 1)), location: 0.48642072081565857),
                    .init(color: Color(#colorLiteral(red: 0.3417165875, green: 0.6236850619, blue: 0.8158343434, alpha: 1)), location: 0.7031797766685486),
                    .init(color: Color(#colorLiteral(red: 0.7098039388656616, green: 0.8156862854957581, blue: 0.5411764979362488, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: 1.953302378392284, y: 0.2823350241083522),
                        endPoint: UnitPoint(x: 1.887281051297495, y: 2.1394425114954974)))
                .overlay(
                    Shape02()
                    .fill(AngularGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.9809638858, green: 0.5471357107, blue: 0.5774925351, alpha: 1)), location: 0.07859717309474945),
                    .init(color: Color(#colorLiteral(red: 0.3396207988, green: 0.1107223555, blue: 0.7444679141, alpha: 1)), location: 0.43838635087013245),
                    .init(color: Color(#colorLiteral(red: 0.3986842632, green: 0.6021121144, blue: 0.8926426172, alpha: 1)), location: 0.6134116053581238),
                    .init(color: Color(#colorLiteral(red: 0.9842380881, green: 0.8453497291, blue: 0.6646212339, alpha: 1)), location: 0.8473764657974243)]),
                        center: UnitPoint(x: 0.4649657830763394, y: 0.42582605622786296)
                      ))
                        .frame(width: 909.16, height: 594.75)
                        .blur(radius: 30)
                        .offset(x: -700, y: -390))
                .overlay(
                Shape03()
                    .fill(LinearGradient(
                            gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.8117647171020508, green: 0.32156863808631897, blue: 0.6274510025978088, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.3843137323856354, green: 0.1764705926179886, blue: 0.7372549176216125, alpha: 1)), location: 0.32398900389671326),
                        .init(color: Color(#colorLiteral(red: 0.2078431397676468, green: 0.24313725531101227, blue: 0.843137264251709, alpha: 1)), location: 0.44163012504577637),
                        .init(color: Color(#colorLiteral(red: 0.2823529541492462, green: 0.6000000238418579, blue: 0.8549019694328308, alpha: 1)), location: 0.7031797766685486),
                        .init(color: Color(#colorLiteral(red: 0.7098039388656616, green: 0.8156862854957581, blue: 0.5411764979362488, alpha: 1)), location: 1)]),
                            startPoint: UnitPoint(x: 0.6932847601384242, y: 0.4025124793110466),
                            endPoint: UnitPoint(x: 0.07165459090335063, y: 0.9445058872153842))).opacity(0.7)
                    .frame(width: 1589.17, height: 1048.92)
                    .offset(x: -390, y:240)
                    .blur(radius: 50))
                .mask(Bubble01().frame(width: 2133.35, height: 1227.95))
                .frame(width: 2133.35, height: 1227.95)
                .offset(x: 680, y:-280)
            
            Circle()
                .fill(LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.5173410177230835, green: 0.30416667461395264, blue: 1, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.5333333015441895, green: 0.972000002861023, blue: 1, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: -1.928348147828274e-9, y: 0.0015703225590688596),
                        endPoint: UnitPoint(x: 0.9999999647429314, y: 1.001570356024242)))
                .frame(width: 118, height: 118)
                .offset(x: 130, y: -300)
            
            LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.78039217, green: 0.3882353008, blue: 0.7764706016, alpha: 0.5)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.1215686277, green: 0.760784328, blue: 0.9294117689, alpha: 0.5)), location: 1)]),
                        startPoint: UnitPoint(x: 0.5, y: -3.0616164697184296e-17),
                        endPoint: UnitPoint(x: 0.5, y: 1))
                .frame(width: 402.51, height: 306.74)
                .mask(Shape102())
                .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: -250)
            
            LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.78039217, green: 0.3882353008, blue: 0.7764706016, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.1215686277, green: 0.760784328, blue: 0.9294117689, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: 0.5573504622514112, y: -0.13066116501191782),
                        endPoint: UnitPoint(x: 0.39396631056291664, y: 0.8780970601166651))
                .frame(width: 570.7, height: 455.77)
                .mask(Shape103())
                .offset(x: 45, y: -270)
                .blur(radius: 3)
            
            LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.26374226808547974, green: 0.08583337068557739, blue: 0.8583333492279053, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.5648985505104065, green: 0.4633854031562805, blue: 0.9041666388511658, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: 0.4997747992543328, y: 0.9999963617946046),
                        endPoint: UnitPoint(x: 1.0016387949736056, y: 0.022911474901536444))
                .frame(width: 512.13, height: 294.39)
                .mask(Shape104())
                .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: -80)
                .blur(radius: 15)
            
            LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.5173410177230835, green: 0.30416667461395264, blue: 1, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.5333333015441895, green: 0.972000002861023, blue: 1, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: -5.169073280519854e-9, y: 0.0015703257303403273),
                        endPoint: UnitPoint(x: 0.9999999352262824, y: 1.0015703722219598))
            .blur(radius: 20)
            .frame(width: 167, height: 167, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .mask(Circle())
            .overlay(
                RadialGradient(
                    gradient: Gradient(stops: [
                                        .init(color: Color(#colorLiteral(red: 0.1843137255, green: 0.7215686275, blue: 1, alpha: 1)), location: 0),
                                        .init(color: Color(#colorLiteral(red: 0.6196078431, green: 0.9254901961, blue: 0.8509803922, alpha: 1)), location: 1)]),
                    center: UnitPoint(x: 0.20449714845584743, y: 0.5004239991789909),
                    startRadius: 1.5206400165393983,
                    endRadius: 151.28048071032234
                )
                .blur(radius: 30)
                .frame(width: 104, height: 104)
                .offset(x: 19, y: 0)
            )
            .offset(x: 160, y: -100)
            
            LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.5098039507865906, green: 0.2549019753932953, blue: 0.7372549176216125, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.8436241746, green: 0.3081428707, blue: 0.5512567163, alpha: 1)), location: 0.5409181714057922),
                    .init(color: Color(#colorLiteral(red: 0.9208502173, green: 0.675716579, blue: 0.5918602943, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: 0.9650679924690451, y: 0.7618796179329179),
                        endPoint: UnitPoint(x: 0.08629089298233295, y: 0.27102936438206093))
            .blur(radius: 0)
            .frame(width: 185.58, height: 191.82, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .mask(MiddleGlob()
            )
            .overlay(
                RadialGradient(
                    gradient: Gradient(stops: [
                                        .init(color: Color(#colorLiteral(red: 0.1843137255, green: 0.7215686275, blue: 1, alpha: 1)), location: 0),
                                        .init(color: Color(#colorLiteral(red: 0.6196078431, green: 0.9254901961, blue: 0.8509803922, alpha: 1)), location: 1)]),
                    center: UnitPoint(x: 0.20449714845584743, y: 0.5004239991789909),
                    startRadius: 1.5206400165393983,
                    endRadius: 151.28048071032234
                )
                .blur(radius: 30)
                .frame(width: 134.43, height: 131.06)
                .offset(x: 19, y: 0)
            )
            .offset(x: 210, y: -525)
        }
    }
}

struct AccountBackground_Previews: PreviewProvider {
    static var previews: some View {
        AccountBackground()
    }
}

struct ShapeBG1: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.6695*width, y: 0.90524*height))
        path.addCurve(to: CGPoint(x: 0.06456*width, y: 0.23199*height), control1: CGPoint(x: 0.20165*width, y: 1.24143*height), control2: CGPoint(x: -0.15028*width, y: 0.60011*height))
        path.addCurve(to: CGPoint(x: 0.55698*width, y: 0.09951*height), control1: CGPoint(x: 0.20578*width, y: -0.00998*height), control2: CGPoint(x: 0.36626*width, y: -0.07704*height))
        path.addCurve(to: CGPoint(x: 0.90033*width, y: 0.0641*height), control1: CGPoint(x: 0.71276*width, y: 0.24373*height), control2: CGPoint(x: 0.78452*width, y: 0.08314*height))
        path.addCurve(to: CGPoint(x: 0.99964*width, y: 0.0641*height), control1: CGPoint(x: 0.93846*width, y: 0.05783*height), control2: CGPoint(x: 0.97063*width, y: 0.05863*height))
        path.addLine(to: CGPoint(x: 0.99964*width, y: 0.92717*height))
        path.addCurve(to: CGPoint(x: 0.6695*width, y: 0.90524*height), control1: CGPoint(x: 0.91881*width, y: 0.82239*height), control2: CGPoint(x: 0.87035*width, y: 0.76091*height))
        path.closeSubpath()
        return path
    }
}

struct ShapeBG2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.13508*width, y: 0.20284*height))
        path.addCurve(to: CGPoint(x: 0.82527*width, y: 0.30579*height), control1: CGPoint(x: 0.29377*width, y: 0.07812*height), control2: CGPoint(x: 0.57038*width, y: -0.00368*height))
        path.addLine(to: CGPoint(x: 0.82527*width, y: 0.95926*height))
        path.addCurve(to: CGPoint(x: 0.33367*width, y: 0.85705*height), control1: CGPoint(x: 0.72719*width, y: 0.93686*height), control2: CGPoint(x: 0.58417*width, y: 0.92644*height))
        path.addCurve(to: CGPoint(x: 0.12618*width, y: 0.75547*height), control1: CGPoint(x: 0.2454*width, y: 0.83259*height), control2: CGPoint(x: 0.17726*width, y: 0.79735*height))
        path.addLine(to: CGPoint(x: 0.13508*width, y: 0.20284*height))
        path.closeSubpath()
        return path
    }
}

struct Bubble: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99821*width, y: 0.97673*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.82561*height), control1: CGPoint(x: 0.53997*width, y: 1.03646*height), control2: CGPoint(x: 0.21736*width, y: 0.97815*height))
        path.addLine(to: CGPoint(x: 0, y: 0.18928*height))
        path.addCurve(to: CGPoint(x: 0.99821*width, y: 0.00416*height), control1: CGPoint(x: 0.23076*width, y: 0.06029*height), control2: CGPoint(x: 0.60131*width, y: -0.01957*height))
        path.addLine(to: CGPoint(x: 0.99821*width, y: 0.97673*height))
        path.closeSubpath()
        return path
    }
}

struct ShapeBlur: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.04515*width, y: 0.0139*height))
        path.addCurve(to: CGPoint(x: -0.59363*width, y: -0.24915*height), control1: CGPoint(x: -0.0878*width, y: -0.30523*height), control2: CGPoint(x: -0.46525*width, y: -0.29425*height))
        path.addCurve(to: CGPoint(x: -0.52788*width, y: 0.32206*height), control1: CGPoint(x: -0.95061*width, y: -0.06125*height), control2: CGPoint(x: -0.55043*width, y: 0.17776*height))
        path.addCurve(to: CGPoint(x: -0.43393*width, y: 0.93086*height), control1: CGPoint(x: -0.4997*width, y: 0.50245*height), control2: CGPoint(x: -0.65939*width, y: 0.78806*height))
        path.addCurve(to: CGPoint(x: 0.37394*width, y: 0.76551*height), control1: CGPoint(x: -0.20848*width, y: 1.07366*height), control2: CGPoint(x: 0.11091*width, y: 0.97596*height))
        path.addCurve(to: CGPoint(x: 1.23818*width, y: 0.6678*height), control1: CGPoint(x: 0.63697*width, y: 0.55506*height), control2: CGPoint(x: 0.63697*width, y: 0.66028*height))
        path.addCurve(to: CGPoint(x: 1.60454*width, y: 0.22435*height), control1: CGPoint(x: 1.71915*width, y: 0.67381*height), control2: CGPoint(x: 1.75484*width, y: 0.37037*height))
        path.addCurve(to: CGPoint(x: 0.87182*width, y: 0.1492*height), control1: CGPoint(x: 1.47302*width, y: 0.09658*height), control2: CGPoint(x: 1.21*width, y: -0.02517*height))
        path.addCurve(to: CGPoint(x: 0.04515*width, y: 0.0139*height), control1: CGPoint(x: 0.4491*width, y: 0.36716*height), control2: CGPoint(x: 0.20483*width, y: 0.39721*height))
        path.closeSubpath()
        return path
    }
}

struct ShapeBlur2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.53214*width, y: 0.44064*height))
        path.addCurve(to: CGPoint(x: 2.61738*width, y: 0.95059*height), control1: CGPoint(x: 1.43562*width, y: 0.31759*height), control2: CGPoint(x: 2.69091*width, y: 0.75805*height))
        path.addCurve(to: CGPoint(x: 1.85509*width, y: 1.05486*height), control1: CGPoint(x: 2.56827*width, y: 1.07918*height), control2: CGPoint(x: 2.17337*width, y: 1.17303*height))
        path.addCurve(to: CGPoint(x: 0.49053*width, y: 1.06817*height), control1: CGPoint(x: 1.19113*width, y: 0.80834*height), control2: CGPoint(x: 0.95835*width, y: 1.00993*height))
        path.addCurve(to: CGPoint(x: -1.29756*width, y: 0.58359*height), control1: CGPoint(x: 0.0623*width, y: 1.12149*height), control2: CGPoint(x: -0.71891*width, y: 0.60277*height))
        path.addCurve(to: CGPoint(x: -1.36719*width, y: 0.33262*height), control1: CGPoint(x: -1.8762*width, y: 0.56441*height), control2: CGPoint(x: -1.52331*width, y: 0.43621*height))
        path.addCurve(to: CGPoint(x: -0.50296*width, y: 0.27826*height), control1: CGPoint(x: -1.21107*width, y: 0.22903*height), control2: CGPoint(x: -0.77384*width, y: 0.21602*height))
        path.addCurve(to: CGPoint(x: 0.53214*width, y: 0.44064*height), control1: CGPoint(x: -0.23208*width, y: 0.3405*height), control2: CGPoint(x: -0.5972*width, y: 0.59445*height))
        path.closeSubpath()
        return path
    }
}

struct Shape102: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.34559*width, y: 0.78926*height))
        path.addCurve(to: CGPoint(x: -0.2269*width, y: 0.20437*height), control1: CGPoint(x: -0.09716*width, y: 1.08132*height), control2: CGPoint(x: -0.43022*width, y: 0.52418*height))
        path.addCurve(to: CGPoint(x: 0.2391*width, y: 0.08928*height), control1: CGPoint(x: -0.09326*width, y: -0.00584*height), control2: CGPoint(x: 0.05862*width, y: -0.0641*height))
        path.addCurve(to: CGPoint(x: 0.56404*width, y: 0.05851*height), control1: CGPoint(x: 0.38653*width, y: 0.21457*height), control2: CGPoint(x: 0.45445*width, y: 0.07505*height))
        path.addCurve(to: CGPoint(x: 1.06293*width, y: 0.17679*height), control1: CGPoint(x: 0.75683*width, y: 0.02942*height), control2: CGPoint(x: 0.78872*width, y: 0.1758*height))
        path.addCurve(to: CGPoint(x: 1.27527*width, y: 0.73276*height), control1: CGPoint(x: 1.33713*width, y: 0.17778*height), control2: CGPoint(x: 1.35964*width, y: 0.52431*height))
        path.addCurve(to: CGPoint(x: 0.85611*width, y: 0.9771*height), control1: CGPoint(x: 1.19089*width, y: 0.94122*height), control2: CGPoint(x: 0.99386*width, y: 1.0474*height))
        path.addCurve(to: CGPoint(x: 0.34559*width, y: 0.78926*height), control1: CGPoint(x: 0.58622*width, y: 0.83936*height), control2: CGPoint(x: 0.64591*width, y: 0.59116*height))
        path.closeSubpath()
        return path
    }
}

struct Shape103: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.6904*width, y: 0.3562*height))
        path.addCurve(to: CGPoint(x: 0.94544*width, y: 0.28593*height), control1: CGPoint(x: 0.77451*width, y: 0.194*height), control2: CGPoint(x: 0.90568*width, y: 0.24537*height))
        path.addCurve(to: CGPoint(x: 0.85533*width, y: 0.59688*height), control1: CGPoint(x: 1.04867*width, y: 0.43358*height), control2: CGPoint(x: 0.88018*width, y: 0.51903*height))
        path.addCurve(to: CGPoint(x: 0.75092*width, y: 0.92542*height), control1: CGPoint(x: 0.82427*width, y: 0.69418*height), control2: CGPoint(x: 0.8468*width, y: 0.87273*height))
        path.addCurve(to: CGPoint(x: 0.48681*width, y: 0.73631*height), control1: CGPoint(x: 0.65504*width, y: 0.97811*height), control2: CGPoint(x: 0.55442*width, y: 0.8853*height))
        path.addCurve(to: CGPoint(x: 0.19498*width, y: 0.57821*height), control1: CGPoint(x: 0.4192*width, y: 0.58733*height), control2: CGPoint(x: 0.40685*width, y: 0.64606*height))
        path.addCurve(to: CGPoint(x: 0.11845*width, y: 0.28679*height), control1: CGPoint(x: 0.02548*width, y: 0.52393*height), control2: CGPoint(x: 0.04856*width, y: 0.35028*height))
        path.addCurve(to: CGPoint(x: 0.38441*width, y: 0.33265*height), control1: CGPoint(x: 0.1796*width, y: 0.23123*height), control2: CGPoint(x: 0.28619*width, y: 0.19479*height))
        path.addCurve(to: CGPoint(x: 0.6904*width, y: 0.3562*height), control1: CGPoint(x: 0.50718*width, y: 0.50497*height), control2: CGPoint(x: 0.58937*width, y: 0.55101*height))
        path.closeSubpath()
        return path
    }
}

struct Shape104: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.50366*width, y: 0.85965*height))
        path.addCurve(to: CGPoint(x: 0.03515*width, y: 0.76859*height), control1: CGPoint(x: 0.42852*width, y: 1.1238*height), control2: CGPoint(x: 0.12264*width, y: 0.96207*height))
        path.addCurve(to: CGPoint(x: 0.09858*width, y: 0.46942*height), control1: CGPoint(x: -0.02328*width, y: 0.63936*height), control2: CGPoint(x: -0.01327*width, y: 0.45202*height))
        path.addCurve(to: CGPoint(x: 0.48738*width, y: 0.10758*height), control1: CGPoint(x: 0.33193*width, y: 0.50573*height), control2: CGPoint(x: 0.39374*width, y: 0.19272*height))
        path.addCurve(to: CGPoint(x: 0.85085*width, y: 0.00645*height), control1: CGPoint(x: 0.58102*width, y: 0.02244*height), control2: CGPoint(x: 0.76422*width, y: 0.04017*height))
        path.addCurve(to: CGPoint(x: 0.99137*width, y: 0.2125*height), control1: CGPoint(x: 0.93749*width, y: -0.02728*height), control2: CGPoint(x: 0.96296*width, y: 0.07589*height))
        path.addCurve(to: CGPoint(x: 0.8811*width, y: 0.50237*height), control1: CGPoint(x: 1.01979*width, y: 0.34911*height), control2: CGPoint(x: 0.95653*width, y: 0.48275*height))
        path.addCurve(to: CGPoint(x: 0.50366*width, y: 0.85965*height), control1: CGPoint(x: 0.80566*width, y: 0.522*height), control2: CGPoint(x: 0.57881*width, y: 0.59551*height))
        path.closeSubpath()
        return path
    }
}

struct Bubble01: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.45426*width, y: 0.18876*height))
        path.addCurve(to: CGPoint(x: 0.00888*width, y: 0.4699*height), control1: CGPoint(x: 0.24243*width, y: -0.22571*height), control2: CGPoint(x: -0.05531*width, y: 0.12195*height))
        path.addCurve(to: CGPoint(x: 0.26609*width, y: 0.74289*height), control1: CGPoint(x: 0.05108*width, y: 0.69862*height), control2: CGPoint(x: 0.13121*width, y: 0.8052*height))
        path.addCurve(to: CGPoint(x: 0.45426*width, y: 0.89124*height), control1: CGPoint(x: 0.37627*width, y: 0.692*height), control2: CGPoint(x: 0.39189*width, y: 0.83598*height))
        path.addCurve(to: CGPoint(x: 0.77264*width, y: 0.97851*height), control1: CGPoint(x: 0.56396*width, y: 0.98846*height), control2: CGPoint(x: 0.60905*width, y: 0.8762*height))
        path.addCurve(to: CGPoint(x: 0.99823*width, y: 0.58644*height), control1: CGPoint(x: 0.93623*width, y: 1.08081*height), control2: CGPoint(x: 1.01137*width, y: 0.79513*height))
        path.addCurve(to: CGPoint(x: 0.79196*width, y: 0.22136*height), control1: CGPoint(x: 0.98508*width, y: 0.37775*height), control2: CGPoint(x: 0.88658*width, y: 0.2135*height))
        path.addCurve(to: CGPoint(x: 0.45426*width, y: 0.18876*height), control1: CGPoint(x: 0.60658*width, y: 0.23675*height), control2: CGPoint(x: 0.59794*width, y: 0.4699*height))
        path.closeSubpath()
        return path
    }
}

struct Shape02: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.32403*width, y: 0.22532*height))
        path.addCurve(to: CGPoint(x: 0.06079*width, y: 0.01841*height), control1: CGPoint(x: 0.26924*width, y: -0.0257*height), control2: CGPoint(x: 0.1137*width, y: -0.01706*height))
        path.addCurve(to: CGPoint(x: 0.08789*width, y: 0.4677*height), control1: CGPoint(x: -0.08631*width, y: 0.16621*height), control2: CGPoint(x: 0.0786*width, y: 0.3542*height))
        path.addCurve(to: CGPoint(x: 0.1266*width, y: 0.94655*height), control1: CGPoint(x: 0.0995*width, y: 0.60959*height), control2: CGPoint(x: 0.0337*width, y: 0.83423*height))
        path.addCurve(to: CGPoint(x: 0.45952*width, y: 0.8165*height), control1: CGPoint(x: 0.21951*width, y: 1.05888*height), control2: CGPoint(x: 0.35113*width, y: 0.98203*height))
        path.addCurve(to: CGPoint(x: 0.81566*width, y: 0.73964*height), control1: CGPoint(x: 0.56791*width, y: 0.65097*height), control2: CGPoint(x: 0.56791*width, y: 0.73373*height))
        path.addCurve(to: CGPoint(x: 0.96663*width, y: 0.39084*height), control1: CGPoint(x: 1.01387*width, y: 0.74437*height), control2: CGPoint(x: 1.02857*width, y: 0.5057*height))
        path.addCurve(to: CGPoint(x: 0.66469*width, y: 0.33173*height), control1: CGPoint(x: 0.91244*width, y: 0.29034*height), control2: CGPoint(x: 0.80405*width, y: 0.19458*height))
        path.addCurve(to: CGPoint(x: 0.32403*width, y: 0.22532*height), control1: CGPoint(x: 0.49049*width, y: 0.50317*height), control2: CGPoint(x: 0.38983*width, y: 0.52681*height))
        path.closeSubpath()
        return path
    }
}

struct Shape03: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.49182*width, y: 0.33767*height))
        path.addCurve(to: CGPoint(x: 0.92337*width, y: 0.67763*height), control1: CGPoint(x: 0.6788*width, y: 0.25563*height), control2: CGPoint(x: 0.93858*width, y: 0.54928*height))
        path.addCurve(to: CGPoint(x: 0.76561*width, y: 0.74715*height), control1: CGPoint(x: 0.9132*width, y: 0.76336*height), control2: CGPoint(x: 0.83147*width, y: 0.82593*height))
        path.addCurve(to: CGPoint(x: 0.48321*width, y: 0.75602*height), control1: CGPoint(x: 0.6282*width, y: 0.5828*height), control2: CGPoint(x: 0.58002*width, y: 0.71719*height))
        path.addCurve(to: CGPoint(x: 0.11316*width, y: 0.43297*height), control1: CGPoint(x: 0.39458*width, y: 0.79157*height), control2: CGPoint(x: 0.23291*width, y: 0.44575*height))
        path.addCurve(to: CGPoint(x: 0.09874*width, y: 0.26566*height), control1: CGPoint(x: -0.0066*width, y: 0.42018*height), control2: CGPoint(x: 0.06643*width, y: 0.33471*height))
        path.addCurve(to: CGPoint(x: 0.2776*width, y: 0.22941*height), control1: CGPoint(x: 0.13105*width, y: 0.1966*height), control2: CGPoint(x: 0.22154*width, y: 0.18792*height))
        path.addCurve(to: CGPoint(x: 0.49182*width, y: 0.33767*height), control1: CGPoint(x: 0.33366*width, y: 0.27091*height), control2: CGPoint(x: 0.2581*width, y: 0.44021*height))
        path.closeSubpath()
        return path
    }
}

struct MiddleGlob: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99903*width, y: 0.5354*height))
        path.addCurve(to: CGPoint(x: 0.5255*width, y: 0.99874*height), control1: CGPoint(x: 0.99903*width, y: 0.77609*height), control2: CGPoint(x: 0.88705*width, y: 0.96836*height))
        path.addCurve(to: CGPoint(x: 0.00458*width, y: 0.56294*height), control1: CGPoint(x: 0.26658*width, y: 0.99874*height), control2: CGPoint(x: 0.00458*width, y: 0.87341*height))
        path.addCurve(to: CGPoint(x: 0.55779*width, y: 0.0037*height), control1: CGPoint(x: 0.00458*width, y: 0.26046*height), control2: CGPoint(x: 0.29887*width, y: 0.0037*height))
        path.addCurve(to: CGPoint(x: 0.99903*width, y: 0.5354*height), control1: CGPoint(x: 0.81671*width, y: 0.0037*height), control2: CGPoint(x: 0.99903*width, y: 0.29472*height))
        path.closeSubpath()
        return path
    }
}
