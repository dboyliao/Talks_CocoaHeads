FFT_LENGTH=524288

test-fft-osx:
	cp tests/test_fft.swift tests/main.swift
	xcrun -sdk macosx swiftc SwiftTest/Sources/*.swift tests/main.swift -o test_fft
	./test_fft
	rm test_fft tests/main.swift

performance-fft-osx:
	cp tests/performance_fft.swift tests/main.swift
	xcrun -sdk macosx swiftc SwiftTest/Sources/*.swift tests/main.swift -o performance_fft
	./performance_fft $(FFT_LENGTH)
	rm performance_fft tests/main.swift