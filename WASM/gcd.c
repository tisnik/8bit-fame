int gcd(int u, int v) {
    while (v) {
        int t = u;
        u = v;
        v = t % v;
    }
    return u;
}

