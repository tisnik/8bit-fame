import sys


# special files to be inserted and appended into output slides
STARTUP_FILE = "startup.bas"
INIT_FILE = "init.bas"



def main(argv):
    # check if input and output files are specified
    if len(argv) < 2:
        print("Error - not enough arguments")
        return 1

    # process input file
    input_file = argv[1]
    output_file = argv[2]
    process(input_file, output_file, STARTUP_FILE)


def process(input_file, output_file, startup_file, init_file):
    """Open input and output files and start processing."""
    with open(output_file, "w") as fout:
        # insert startup code into the output file
        insert_file(fout, startup_file)

        # process input file and generate slide section
        with open(input_file, "r") as fin:
            for line in fin.readlines():
                line = line.strip()
                print(line)

        # insert init code into the output file
        insert_file(fout, init_file)


def insert_file(fout, filename):
    """Insert content of selected file into the output file."""
    with open(filename, "r") as fin:
        for line in fin.readlines():
            line = line.strip()
            print(line, file=fout)


# If this script is started from command line, run the `main` function which is
# entry point to the processing.
if __name__ == "__main__":
    result = main(sys.argv)
    sys.exit(result)
