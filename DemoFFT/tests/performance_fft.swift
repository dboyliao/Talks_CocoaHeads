import Foundation
import Accelerate

var N = Int(Process.arguments[1])!
var repeatTime = 1

var sig = [Double](count:N, repeatedValue:0)
for i in 0..<N {
    sig[i] = Double(i+1)
}

colorPrint("===== Start Python FFT Performance Test =====", color:"yellow")
system("python2 tests/fft_numpy.py \(N) \(repeatTime)")

colorPrint("===== Start Swift FFT Performance Test ====", color:"yellow")

var setup = vDSP_DFT_zop_CreateSetupD(nil, vDSP_Length(N), vDSP_DFT_Direction.FORWARD)

func testPerformanceFFTNoSetup() -> Int {

    fft(sig)

    return 0
}

func testPerformanceFFTWithSetup() -> Int {

    fft(sig, setup:setup)

    return 0
}

testEqual("Swift FFT Performance Test No Setup", test: testPerformanceFFTNoSetup, expect:0)
testEqual("Swift FFT Performance Test With Setup", test: testPerformanceFFTWithSetup, expect:0)

vDSP_DFT_DestroySetupD(setup)