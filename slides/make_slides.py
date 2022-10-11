import sys


def main(argv):
    # check if input and output files are specified
    if len(argv) < 2:
        print("Error - not enough arguments")
        return 1

    # process input file
    input_file = argv[1]
    output_file = argv[2]



# If this script is started from command line, run the `main` function which is
# entry point to the processing.
if __name__ == "__main__":
    result = main(sys.argv)
    sys.exit(result)
