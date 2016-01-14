import Accelerate
import Foundation

func fft(sig:[Double], setup previous_setup:vDSP_DFT_SetupD?=nil) -> (realp:[Double], imagp:[Double]) {

    // Get the nearest power of 2.
    let log2N = vDSP_Length(log2f(Float(sig.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    var input = [Double](sig[0..<fftN])
    var zeros = [Double](count:fftN, repeatedValue:0)

    var coef_real = [Double](count: fftN, repeatedValue:0.0)
    var coef_imag = [Double](count: fftN, repeatedValue:0.0)

    // setup DFT and execute.
    var setup:vDSP_DFT_SetupD

    if previous_setup == nil {

        setup = vDSP_DFT_zop_CreateSetupD(nil, vDSP_Length(fftN), vDSP_DFT_Direction.FORWARD)

    } else {
        setup = previous_setup!
    }

    vDSP_DFT_ExecuteD(setup, &input, &zeros, &coef_real, &coef_imag)

    if previous_setup == nil {
        // destroy setup.
        vDSP_DFT_DestroySetupD(setup)
    } 

    return (coef_real, coef_imag)
}


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