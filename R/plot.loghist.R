plot.loghist <- function (x, freq = equidist, density = NULL, angle = 45, col = NULL, 
    border = par("fg"), lty = NULL, main = paste("Histogram of", 
        paste(x$xname, collapse = "\n")), sub = NULL, xlab = x$xname, 
    ylab, xlim = range(x$breaks), ylim = NULL, axes = TRUE, labels = FALSE, 
    add = FALSE, ann = TRUE, ...) 
{
    equidist <- if (is.logical(x$equidist)) 
        x$equidist
    else {
        h <- diff(x$breaks)
        diff(range(h)) < 1e-07 * mean(h)
    }
    if (freq && !equidist) 
        warning("the AREAS in the plot are wrong -- rather use 'freq = FALSE'")
    y <- if (freq) 
        x$counts
    else x$density
    
    # log y 
    log <- TRUE
    if(log) {
      y2 <- rep(Inf, length(y))
      y2[y > 0] <- log(y[y > 0])
      log0 <- min(y2) - 1
      y2[y2 == Inf] <- log0
      y <- y2
      uy <- sort(unique(y))
      # y <- factor(y, levels = uy, labels=exp(uy))
    }
    nB <- length(x$breaks)
    if (is.null(y) || 0L == nB) 
        stop("'x' is wrongly structured")
    dev.hold()
    on.exit(dev.flush())
    if (!add) {
        if (is.null(ylim)) 
            ylim <- range(y)
        if (missing(ylab)) 
            ylab <- if (!freq) 
                "Density"
            else "Frequency"
        plot.new()
        plot.window(xlim, ylim, "", ...)
        if (ann) 
            title(main = main, sub = sub, xlab = xlab, ylab = ylab, 
                ...)
        if (axes) {
            axis(1, ...)
            axis(2, at=axTicks(2), ...)
        }
    }
    rect(x$breaks[-nB], 0, x$breaks[-1L], y, col = col, border = border, 
        angle = angle, density = density, lty = lty)
    if ((logl <- is.logical(labels) && labels) || is.character(labels)) 
        text(x$mids, y, labels = if (logl) {
            if (freq) 
                x$counts
            else round(x$density, 3)
        }
        else labels, adj = c(0.5, -0.5))
    invisible()
}
