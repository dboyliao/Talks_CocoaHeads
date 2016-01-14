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


var N = Int(1 << 4)
var repeatTime = 1000
colorPrint("===== Start Python FFT Performance Test =====", color:"yellow")
system("python2 tests/fft_numpy.py \(N) \(repeatTime)")

var sig = [Double](count:N, repeatedValue:0)
for i in 0..<N {
    sig[i] = Double(i+1)
}

let answer_real:[Double] = [136, -8, -8, -8, -8, -8, -8, -8, -8,
                            -8, -8, -8, -8, -8, -8, -8]
let answer_imag:[Double] = [0, 40.21871594, 19.3137085, 11.9728461,
                            8, 5.3454291, 3.3137085, 1.59129894,
                            0, -1.59129894, -3.3137085, -5.3454291,
                            -8, -11.9728461, -19.3137085, -40.21871594]

func testFFTNoPreviousSetupReal() -> [Double] {

    let (real, _) = fft(sig)
    return real

}

func testFFTNoPreviousSetupImag() -> [Double] {

    let (_, imag) = fft(sig)
    return imag
}

testEqualInTol("FFT No Previous Setup Real", test:testFFTNoPreviousSetupReal, 
               expect:answer_real, tol:1e-7)
testEqualInTol("FFT No Previous Setup Imag", test:testFFTNoPreviousSetupImag, 
               expect:answer_imag, tol:1e-7)

let setup = vDSP_DFT_zop_CreateSetupD(nil, vDSP_Length(N), vDSP_DFT_Direction.FORWARD)

func testFFTWithPreviousSetupReal() -> [Double] {

    let (real, _) = fft(sig, setup:setup)

    return real
}

func testFFTWithPreviousSetupImag() -> [Double] {

    let (_, imag) = fft(sig, setup:setup)

    return imag
}

testEqualInTol("FFT With Previous Setup Real", test:testFFTWithPreviousSetupReal, 
               expect:answer_real, tol:1e-7)
testEqualInTol("FFT With Previous Setup Imag", test:testFFTWithPreviousSetupImag, 
               expect:answer_imag, tol:1e-7)

vDSP_DFT_DestroySetupD(setup)
