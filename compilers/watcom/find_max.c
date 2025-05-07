typedef unsigned int uint;

uint find_max(uint *array, uint length) {
    uint max = 0;
    uint i;
    uint *item = array;

    for (i=0; i<length; i++) {
        if (max < *item) {
            max = *item;
        }
        item++;
    }
    return max;
}
