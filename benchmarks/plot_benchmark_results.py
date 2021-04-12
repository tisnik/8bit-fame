#!/usr/bin/env python3

import sys
import pandas as pd
import matplotlib.pyplot as plt

# Check if command line argument is specified (it is mandatory).
if len(sys.argv) < 2:
    print("Usage:")
    print("  plot_benchmark_results.py ")
    print("Example:")
    print("  plot_benchmark_results.py data.tsv")
    sys.exit(1)

# First command line argument should contain name of input CSV.
input_file = sys.argv[1]

df = pd.read_csv(input_file, index_col=0)

print(df)
print()

print(df.info())
print()

print(df.describe())
print()


# Create new bar chart
df.plot(kind="barh")

plt.xlabel("Čas běhu benchmarku (s)")
plt.tight_layout()

# Save the plot
plt.savefig("bench.png")

# Try to show the plot on screen
plt.show()
