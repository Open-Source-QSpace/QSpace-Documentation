```
function contractQS()

    Contract set of QSpace tensors in a pairwise fashion
    as described with usage #1 and #2 below. This automatically
    also takes care of the underlying Clebsch Gordan coefficient
    spaces if present based on X-symbols.

    Each QSpace can be used as is, or as its 'conjugate' where the
    conjugate of a QSpace A, i.e. conj(A) is defined as the QSpace

     1) with all `arrows' reversed
     2) keeping the SAME qlabels on all legs
     3) and complex conjugation of all data{} if applicable,
        i.e., if the (reduced) matrix elements are complex.

    Because of (1), the specification of conjugate flags (`conj-flags')
    is also important for QSpaces with all-real matrix elements.
    For reversing individual arrows, see getIdentitQS(..,'-0').

Usage #1: S=contractQS(A, ica, B, icb [, perm, OPTS ]);

    Plain contraction of a single pair of QSpaces, A and B,
    with respect to given explicitly specified  sets of
    contraction indices ica and icb, which can be specified

      - numerically (e.g. [1 2]),
      - or as strings (e.g. '1,2', or '1 2')
      - or as compact strings (e.g. '1,2', or '12')

    The last 'compact format' is only possible / unique,
    of course, if the tensors A and B do not have more than
    9 legs (which basically never occurs), such that the
    contraction indices reamin in the single digits
    (this can be further relaxed, though, by extending the
    digital range to letter, i.e. using a-z after 0-9).

    The recommended way to specify conj-flag with usage #1
    is together with the contraction indices in string notation!
    For example,

      contractQS(A,[1 3],B,[1 3],'conjA')  is equivalent to
      contractQS(A,'1,3;*',B,[1 3])        is equivalent to
      contractQS(A,'13*',B,'13')

    (deprecated) options specific to usage #1:

      'conjA'  use complex conjugate of A for contraction
      'conjB'  use complex conjugate of B for contraction

Usage #2: S=contractQS(A,..,{B,..,{C,..}},.. [, perm, OPTS ]);

    Generalized 'cell-contraction' of tensors: when encountering
    a cell, the content of that cell is contracted first, before
    using its result. This allows the specification of an entire
    patter of pairwise contractions based on a nested cell structure
    where the lowest-level contractions are performed first.
    An optional fully enveloping outer cell bracket at `base' level
    as in S=contractQS({A,..,{B,..,{C,..}},..} [, perm, OPTS ])
    is permitted, which may be used e.g., when debugging nested
    parts of cell-contractions.

    Cell contractions are furthermore based on QSpace `itags'
    i.e. string labels for indices with up to 8chars, and which
    are specified in QSpace.info.itags. This offers automated
    contraction ('auto-contraction') of pairs of tensors solely
    based on matching itags! Uusage #2 therefore does not (also)
    allow explicit specification of contraction indices as in
    usage #1.  Therefore itags (plus conj-flags) must be unique.

    itags must always also contain individual conjugate flags
    (this represent the bare minimum that must be specified with
    each QSpacein v3): the conjugate flags on individual indices
    (legs) of a tensor determine  whether that index (leg) is
    in- or out-going, with the convention that

        all out-going indices have a trailing * in their itags!

    For example, an A-tensor with L(eft), R(ight), s(=local)
    indices may have itags A.info.itags={'L','R*',s'}
    assuming (L,R,s) index order.

    In usage #2, for every operator additional optional strings
    can be specified, appearing right after the affected tensor
    e.g. QSpace A:

      A,'!ij'  do not contract indices specified by ij (in compact
               format) despite they share common matching itags.
      A,'*'    apply overall (complex) conjugation on given input
               tensor A (see early comments above)
      A,'!ij*' both of the above in a single instruction
               the conjugate flag '*' always trailing.

      A,'ij'   [07/2023]
      A,'ij*'  explicitly specify indices to contract
               this is intended only for the case of degenerate itags
               i.e., when identical itags appear on multiple legs
               including the same conjugate flag.

    itags may be set or adapted on the fly (this is performed
    prior to the auto-contraction together wit the above directions)

      X,'--op:<tag>[:<opl=op>]'
         specify itags for given (e.g. local) operator.

         The last option considers X an operator, and hence assumes
         operator itags '<tag>;<tag>*[;opl*]' for QSpace X;
         the default operator label is `op', but may be changed
         by specifying a trailing ':<opl>' as indicated above.
         As a safeguard, this issues a warning, if existing itags are
         overwritten. This is relevant e.g. for local operators that
         are applied to a very specific site with associated itag.

         [11/2018] the specified <tag> may now also represent
         a regular expression (regexp), recognized by non-alphabetic
         special characters, while ignoring conj-flags (without
         special characters, the specified <tag> is taken as is!).
         This usage then searches for a matching itag in the paired
         up QSpace (cell) in the contraction.

         Ex. Consider A some QSpace with a single local index
         that starts with `s', e.g., like 's010' for site 10;
         then contract(A,Xloc,'-op:^s') will autocontract
         the local operator Xloc to the correct local index in A
         (here the regex `^s' indicates `starts with s');
         An alternative operator itag may still be specified
         by adding a trailing ':opl' as indicated earlier.

      A,'--itag:s/pat/rep/[gi]   [07/2023]

         replace/modify existing itags on the fly for a particular
         recursive level of a cell contraction based on regular
         expressions (regex; using ECMAScript grammar, cf. C++/regex).
         The syntax is much analogous to perl regex.

         The trailing flags enable case insensitive replacement [i]
         and global replacement [g] of all possible matches
         (by default, only the first match is replaced).

    An adaptation of usage #2 can also be used
    for plain sequential contractions

        S=contractQS(A [,flagsA],B [,flagsB],C,... [, perm, OPTS ])

    which is equivalent to
    S=contractQS({A [,flagsA],{B [,flagsB], {C,...}}}, [,perm,OPTS ]).
    That is, by grouping A*(B*(C*...)), sequential contractions start
    from the right end onwards to the beginning of the specified set.
    This structure is also permitted at any lower level inside cell
    contractions. Non-contracted indices are always collected in the
    order they appear in the input.

The remaining trailing OPTS are

    perm  optional permutation (non-string) on the final object;
          this permutation can be shorter than the actual rank
          of the resulting QSpace, which then is completed as
          an identity permutation on the remainder of indices.

          By permitting the specification of indices to contract
          also in contractions based on itags (cell-contractions)
          there is a potential ambiguity of whether perm should
          be interpreted as indices on the last specified tensor
          (the latter may also be represented in compact string
          format for better differentiation).

          Hence the rules for perm to be interpreted as permutation
          requires that (i) it is a valid permutation of length
          r>=2 to start with, and (ii) that it is in numeric format,
          i.e., not written as compact string. Valid examples are
          [2 1], [2 3 1], but not, e.g., 1, [2 3], or '21'.

          The ambiguity above is fully circumvented when also
          wrapping the last contraction at base level into a cell,
          such as contractQS({A,...},perm [,'-v']) [see above],
          in which case perm is always interpreted as permutation
          on the overall result, irrespective of rank or whether
          specified as numeric or compact string index. In case
          of a string, this then also permits to specify an optional
          conjugate flag to be applied on the overall result.

    '-v'  debug mode that shows all levels of a cell contraction
          together with the actual contractions performed
          based on shown itags. Internally, degenerate itags are
          frequently flagged by making use of signed characters,
          which makes them unique and thus differentiate them.
          When printed, flagged itags are formatted as "<itag>|b"
          where the character `|' separates the actual itag string
          from number b (int8 decimal) which in its binary form
          reflects the internal flags.

Mixed usage of #2 and #1 is not possible.
Usage #2 is typically recommended because auto-contraction
makes it far easier to contract entire networks in a single go
without having to manually track and specify index locations.

AW (C) May 2010-2023
```