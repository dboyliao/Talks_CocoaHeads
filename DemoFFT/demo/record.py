import subprocess
from pyaudio_wrapper import Recorder, Microphone

subprocess.call("say -v Boing 'recording start'", shell = True)

recorder = Recorder()
with Microphone(chunk_size = 8192) as source:

    audio = recorder.record(source, max_pause_time = 1, verbose = True)

subprocess.call("say -v Boing 'recording complete'", shell = True)

audio.save("/Users/DboyLiao/Documents/SwiftEvents/CocoaHeads/DemoFFT/demo/sound.wav")