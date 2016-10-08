import std.experimental.logger;

enum size_t defaultn = 32;

void main(string[] args)
{
    trace;
    import std.stdio;
    import std.string : format;
    import std.math : lg = log2;
    immutable
        s = args.getFromOpt("dim|s", size_t(0)),
        m = args.getFromOpt("lgcard|m", size_t(0)),
        n = args.getFromOpt("digits|n", size_t(defaultn)),
        q = args.getFromOpt("trial|q", size_t(0)),
        u = args.getFromOpt("param|u", real(2)),
        lgu = u.lg;
    auto output = File("s%02d-m%02d-q%d.tsv".format(s, m, q), "w");
    import digitalnet.implementation;
    import wafom.approximated : aw = WAFOM;
    import wafom.precomputation : pw = WAFOM;
    auto ub = loga(s, u), lb = logb(s, u);
    foreach (i; 0..q)
    {
        auto dn = randomDigitalNet(Precision(n), DimensionR(s), DimensionF2(m));
        auto p = dn.pw(lgu).lg, a = dn.aw(lgu).lg;
        assert (lb <= a+ub-p);
        assert (a+ub-p <= ub);
        output.writefln("%s%(\t%f%)", dn, [
            p,
            a+ub,
            lb,
            a+ub-p,
            ub]);
    }
    trace;
}

auto lgi1d(in real u)
{
    import std.math : expm1, lg = log2;
    return ((-u).expm1 / -u).lg;
}

real loga(in size_t s, in real u)
{
    return u.lgi1d * s;
}
real logb(in size_t s, in real u, in size_t n=defaultn)
{
    import std.math : exp2;
    import std.algorithm : min;
    auto ret = real.infinity;
    foreach (ptrdiff_t w; 1..n)
    {
        auto c = ((-w).exp2 * u).lgi1d;
        foreach (i; 1..w+1)
            c += ((-i).exp2 * u).lgi1d;
        ret = ret.min(c);
    }
    return ret * s;
}

T getFromOpt(T)(string[] args, string opt, T defaultValue=T.init)
{
    import std.getopt, std.exception;
    import std.string : format;
    auto ret = defaultValue;
    args.getopt(config.passThrough, opt, &ret);
    (ret != T.init).enforce("Need a %s option %s".format(typeid (T), opt));
    return ret;
}
