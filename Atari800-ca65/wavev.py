import matplotlib.pyplot as plt
import numpy as np
import wave
import sys


spf = wave.open("atari000.wav", "r")

# Extract Raw Audio from Wav File
signal = spf.readframes(-1)
signal = np.frombuffer(signal, np.int16)


# If Stereo
if spf.getnchannels() == 2:
    print("Just mono files")
    sys.exit(0)

plt.figure(1)
plt.plot(signal[0:1000])
plt.show()
plt.savefig("01.png")
