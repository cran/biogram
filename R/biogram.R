#' biogram - analysis of biological sequences using n-grams
#'
#' @description \code{biogram} package for the analysis of
#' nucleic acid and protein sequences using n-grams. Possible applications include
#' motif discovery, feature selection, clustering, and classification.
#' 
#' @section n-grams:
#' n-grams (k-tuples) are sets of \code{n} characters derived from the input sequence(s).
#' They may form continuous sub-sequences or be discontinuous. For example, from the 
#' sequence of nucleotides \code{AATA} one can extract the following continuous 
#' 2-grams (bigrams): \code{AA}, \code{AT} and \code{TA}. Moreover, there are two
#' possible bigrams separated by a single space: \code{A_T} and \code{A_A}, and one
#' bigram separated by two spaces: \code{A__A}.
#' 
#' Another important n-gram parameter is its position. Instead of just counting n-grams,
#' one may want to count how many n-grams occur at a given position in multiple (e.g. related)
#' sequences. For example, in the sequences \code{AATA} and \code{AACA} there is only one
#' bigram at position 1: \code{AA}, but there are two bigrams at position two: \code{AT} and
#' \code{AC}. The following notation is used for position-specific n-grams: \code{1_AA},
#' \code{2_AT}, \code{2_AC}.
#' 
#' In the \code{biogram} package, the \code{\link{count_ngrams}} function is used for
#' counting and extracting n-grams. Using the \code{d} argument the user can specify the
#' distance between elements of the n-grams. The \code{pos} argument can be used to enable
#' position specificity.
#' 
#' @section n-gram data dimensionality:
#' We note that n-grams suffer from the curse of dimensionality. For example, for a peptide
#' of length 6 \eqn{20^{n}} n-grams and \eqn{6 \times 20^{n}} positioned n-grams are possible.
#' Data sets of such an enormous size are hard to manage and analyze in R.
#' 
#' The \code{biogram} package deals with both of the abovementioned problems. It uses 
#' innate properties of the n-gram data which usually can be represented by sparse
#' matrices. Data storage is done using functionalities from the \code{slam} package. To ease 
#' the selection of significant features, \code{biogram} provides the user with QuiPT, 
#' a very fast permutation test for binary data (see \code{\link{test_features}}).
#' 
#' Another way of reducing dimensionality is the aggregation of sequence residues into more 
#' general groups. For example, all positively-charged amino acids may be aggregated into
#' one group. This action can be performed using the \code{\link{degenerate}} function.
#' 
#' @import slam
#' @importFrom bit as.bit
#' @author Michal Burdukiewicz, Piotr Sobczyk, Chris Lauber
#' @docType package
#' @name biogram-package
#' @aliases biogram
#' @examples
#' #use data set from package
#' data(human_cleave)
#' #first nine columns represent subsequent nine amino acids from cleavage sites
#' #degenerate the sequence to reduce the dimensionality of the problem
#' #(use five groups instead of 20 amino acids)
#' deg_seqs <- degenerate(human_cleave[, 1L:9], 
#'                       list(`1` = c(1, 6, 8, 10, 11, 18), 
#'                            `2` = c(2, 13, 14, 16, 17), 
#'                            `3` = c(5, 19, 20), 
#'                            `4` = c(7, 9, 12, 15), 
#'                            '5' = c(3, 4)))
#' #extract trigrams
#' trigrams <- count_ngrams(deg_seqs, 3, 1L:4, pos = TRUE)
#' #select features that differ between the two target groups
#' test1 <- test_features(human_cleave[, "tar"], trigrams)
#' #see a summary of the results
#' summary(test1)
#' #aggregate features in groups based on their p-value
#' gr <- cut(test1)
#' #analyze deeper the most significant n-grams
#' #get position map of n-grams
#' position_ngrams(gr[[1]])
#' #transform n-grams to more readable form
#' decode_ngrams(gr[[1]])
NULL