#!/usr/bin/env swift
import Accelerate

var N = 16 // 16 samples
var sig = [Double](count:N, repeatedValue:0)
var zeros = [Double](count:N, repeatedValue:0)

for i in 0..<N{
    sig[i] = Double(i+1)
}

// Create setup
// setup is a struct which contains neccessary information for fft.\
var setup = vDSP_DFT_zop_CreateSetupD(nil, vDSP_Length(N), vDSP_DFT_Direction.FORWARD)

// Output buffers
var coef_real = [Double](count:N, repeatedValue:0)
var coef_imag = [Double](count:N, repeatedValue:0)

vDSP_DFT_ExecuteD(setup, &sig, &zeros, &coef_real, &coef_imag)
vDSP_DFT_DestroySetupD(setup)

for i in 0..<N {
    print("\(coef_real[i]) \(coef_imag[i])j")
}