
protocol AdvancedLifeSupport {
    func performCPR()
}

class EmergencyCallHandler {//オペレーター（指示出す人，ハンドラー）
    var delegate: AdvancedLifeSupport?//オペレーターの代わりに処置を行う人(delegate)はAdvancedLifeSupportプロトコルを満たしている必要がある．
    
    func assessSituation() {
        print("Can you tell me what happened?")
    }
    
    func medicalEmergency() {
        delegate?.performCPR()
    }
}

struct Paramedic: AdvancedLifeSupport {//救急隊員はALSを満たしている．ProtocolがData typeとして使えるからこれが可能になる．
    
    init (handler: EmergencyCallHandler){//EmergencyCallHandler型のプロパティを渡すことで，誰がハンドラーかを知る
        handler.delegate = self//ハンドラーの代理として処置を行う．代理(delegate)を自分(Paramedic)に指定
    }
    
    func performCPR() {
        print("The paramedic does chest compressions, 30 per second.")
    }
}

class Doctor: AdvancedLifeSupport {
    
    init(handelr: EmergencyCallHandler) {
        handelr.delegate = self
    }
    
    func performCPR() {
        print("The doctor does chest compressions, 30 per second.")
    }
    
    func useStethscope() {
        print("Listening for heart sounds.")
    }
    
}

class Surgeon: Doctor {//外科医クラスは医師クラスを継承しているので，ALSプロトコルは既に採用されている．
    override func performCPR() {
        super.performCPR()
        print("Sing a song.")
    }
    
    func useElectricDrill() {
        print("Whirr...")
    }
}

let emilio = EmergencyCallHandler()//オペレーター（ハンドラー）
//let pete = Paramedic(handler: emilio)//救急隊員のピートはエミリオからの指示で行動

let angela = Surgeon(handelr: emilio)

emilio.assessSituation()
emilio.medicalEmergency()
