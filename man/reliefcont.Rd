\name{reliefcont}
\alias{reliefcont}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Feature selection by the Relief Algorithm for datasets with only continuous features}
\description{
This function applies Relief to datasets containing only continuous attributes.
}
\usage{
reliefcont(data, nosample, threshold)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{ The name of the dataset }
  \item{nosample}{ The size of the sample drawn and use to update the relevance of the features}
  \item{threshold}{ The threshold for choosing the relevant features.}
}
\author{ Edgar Acuna}
\seealso{\code{\link{relief}}}
\keyword{methods}
