unsigned int gcd(unsigned int u, unsigned int v) {
    while (v) {
        int t = u;
        u = v;
        v = t % v;
    }
    return u;
}

