test-fft-osx:
	cp tests/test_fft.swift tests/main.swift
	xcrun -sdk macosx swiftc SwiftTest/Sources/*.swift tests/main.swift -o test_fft
	./test_fft
	rm test_fft tests/main.swift