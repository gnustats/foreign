% This file is part of the 'foreign' package for R
% It is distributed under the GPL version 2 or later

\name{read.dta}
\alias{read.dta}
\title{Read Stata Binary Files}
\description{
  Reads a file in Stata version 5--12 binary format into a data frame. 
  
  Frozen: will not support Stata formats after 12.
}
\usage{
read.dta(file, convert.dates = TRUE, convert.factors = TRUE,
         missing.type = FALSE,
         convert.underscore = FALSE, warn.missing.labels = TRUE)
}
\arguments{
  \item{file}{a filename or URL as a character string.}
  \item{convert.dates}{Convert Stata dates to \code{Date} class, and
    date-times to \code{POSIXct} class?}
  \item{convert.factors}{Use Stata value labels to create factors?
    (Version 6.0 or later).}
  \item{missing.type}{For version 8 or later, store information about
    different types of missing data?}
  \item{convert.underscore}{Convert \code{"_"} in Stata variable names
    to \code{"."} in R names?}
  \item{warn.missing.labels}{Warn if a variable is specified with value
    labels and those value labels are not present in the file.}
}
\details{
  If the filename appears to be a URL (of schemes \samp{http:},
  \samp{ftp:} or \samp{https:}) the URL is first downloaded to a
  temporary file and then read.  (\samp{https:} is only supported on
  some platforms.)
  
  The variables in the Stata data set become the columns of the data
  frame.  Missing values are correctly handled.  The data label,
  variable labels, timestamp, and variable/dataset characteristics
  are stored as attributes of the data frame.

  By default Stata dates (\%d and \%td formats) are converted to \R's
  \code{Date} class, and variables with Stata value labels are
  converted to factors.  Ordinarily, \code{read.dta} will not convert
  a variable to a factor unless a label is present for every level.  Use
  \code{convert.factors = NA} to override this.  In any case the value
  label and format information is stored as attributes on the returned
  data frame.  Stata's date formats are sketchily documented: if
  necessary use \code{convert.dates = FALSE} and examine the attributes
  to work out how to post-process the dates.
  
  Stata 8 introduced a system of 27 different missing data values.  If
  \code{missing.type} is \code{TRUE} a separate list is created with the
  same variable names as the loaded data.  For string variables the list
  value is \code{NULL}.  For other variables the value is \code{NA}
  where the observation is not missing and 0--26 when the observation is
  missing.  This is attached as the \code{"missing"} attribute of the
  returned value.

  The default file format for Stata 13, \code{format-115}, is
  substantially different from those for Stata 5--12.
}
\value{
  A data frame with attributes.  These will include \code{"datalabel"},
  \code{"time.stamp"}, \code{"formats"}, \code{"types"},
  \code{"val.labels"}, \code{"var.labels"} and \code{"version"} and may
  include \code{"label.table"} and \code{"expansion.table"}.  
  Possible versions are \code{5, 6, 7},
  \code{-7} (Stata 7SE, \sQuote{format-111}), \code{8} (Stata 8 and 9,
  \sQuote{format-113}), \code{10} (Stata 10 and 11, \sQuote{format-114}).
  and \code{12} (Stata 12, \sQuote{format-115}).
  
  The value labels in attribute \code{"val.labels"} name a table for
  each variable, or are an empty string.  The tables are elements of the
  named list attribute \code{"label.table"}: each is an integer vector with
  names.
}
\references{
  Stata Users Manual (versions 5 & 6), Programming manual (version 7),
  or online help (version 8 and later) describe the format of the files.
  Or directly at \url{http://www.stata.com/help.cgi?dta_114} and
  \url{http://www.stata.com/help.cgi?dta_113}, but note that these have
  been changed since first published.
}

\author{
  Thomas Lumley and R-core members: support for value labels by
  Brian Quistorff.
}
\seealso{
  A different approach is available in package \pkg{memisc}: see its
  help for \code{Stata.file}, at the time of writing not for Stata 12 or
  later.

  \code{\link{write.dta}},
  \code{\link{attributes}},
  \code{\link{Date}},
  \code{\link{factor}}
}
\examples{
data(swiss)
write.dta(swiss,swissfile <- tempfile())
read.dta(swissfile)
}
\keyword{file}
