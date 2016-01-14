import Accelerate

var N = Int(1 << 4)

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
