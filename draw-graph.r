for (file.name in list.files(pattern=".tsv"))
{
    d = read.table(file.name, sep="\t")
    lgW = d$V2
    lower = d$V4[1]
    ratio = d$V5
    upper = d$V6[1]

    pdf(sub("tsv", "pdf", file.name))
    plot(lgW, ratio, ylim=c(lower, upper), xlab="lg W(P)", ylab="lg Err(exp;P)/W(P)")
    abline(h=lower, lty=2)
    abline(h=upper, lty=2)
    dev.off()

    lgAW = d$V3
    pdf(sub("tsv", "raw.pdf", file.name))
    plot(lgW, lgAW, xlab="lg W(P)", ylab="lg Err(exp;P)")
    abline(lower, 1, lty=2)
    abline(upper, 1, lty=2)
    dev.off()
}
