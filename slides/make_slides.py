import sys


# special files to be inserted and appended into output slides
STARTUP_FILE = "startup.bas"


def main(argv):
    # check if input and output files are specified
    if len(argv) < 2:
        print("Error - not enough arguments")
        return 1

    # process input file
    input_file = argv[1]
    output_file = argv[2]
    process(input_file, output_file, STARTUP_FILE)



def process(input_file, output_file, startup_file):
    """Open input and output files + start processing."""
    with open(output_file, "w") as fout:
        # insert startup code into the output file
        with open(startup_file, "r") as fin:
            for line in fin.readlines():
                line = line.strip()
                print(line, file=fout)

        with open(input_file, "r") as fin:
            for line in fin.readlines():
                line = line.strip()
                print(line)


# If this script is started from command line, run the `main` function which is
# entry point to the processing.
if __name__ == "__main__":
    result = main(sys.argv)
    sys.exit(result)
