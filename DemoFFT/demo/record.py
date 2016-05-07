#!/usr/bin/env python
# -*- coding: utf-8 -*-
import subprocess
import os
from pyaudio_wrapper import Recorder, Microphone

def main():
    subprocess.call(["say", "-v", "Boing" , "'recording start'"])
    recorder = Recorder()

    with Microphone(chunk_size = 8192, channels = 2) as source:
        audio = recorder.record(source, max_pause_time = 1, verbose = True)
        subprocess.call(["say", "-v", "Boing", "'recording complete'"])

    path = os.path.abspath("../demo//sound.wav")
    audio.save(path)

if __name__ == "__main__":
    main()
