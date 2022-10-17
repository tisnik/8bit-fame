import sys


# special files to be inserted and appended into output slides
STARTUP_FILE = "startup.bas"
INIT_FILE = "init.bas"
LOAD_BITMAP_FILE = "load.bas"


def main(argv):
    # check if input and output files are specified
    if len(argv) < 2:
        print("Error - not enough arguments")
        return 1

    # process input file
    input_file = argv[1]
    output_file = argv[2]
    process(input_file, output_file, STARTUP_FILE, INIT_FILE, LOAD_BITMAP_FILE)


def process(input_file, output_file, startup_file, init_file, load_bitmap_file):
    """Open input and output files and start processing."""
    with open(output_file, "w") as fout:
        # insert startup code into the output file
        insert_file(fout, startup_file)

        # process input file and generate slide section
        with open(input_file, "r") as fin:
            convert_markdown_to_basic(fout, fin)

        # insert init code into the output file
        insert_file(fout, init_file)

        # insert code to load images the output file
        insert_file(fout, load_bitmap_file)


def convert_markdown_to_basic(fout, fin):
    """Convert text in Markdown to BASIC slides."""
    slide_number = 0

    for line in fin.readlines():
        line = line.strip()
        print(line, file=fout)


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
