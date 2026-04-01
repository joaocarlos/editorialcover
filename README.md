# Editorial Cover Letter Class

This repository contains a lightweight LaTeX class for editorial submission material:

- cover letters
- title pages

The main class is `editorialcover.cls`.

The recommended structure is:

- `submission-data.tex` for shared manuscript metadata used by multiple documents
- `cover-letter.tex` for the cover-letter-specific metadata and body text
- `title-page.tex` for the standalone title page, including authors and affiliations

## Usage

### Shared metadata

```tex
\journal{Journal Name}
\articleTitle{Your Manuscript Title}
```

### Cover letter

```tex
\documentclass{editorialcover}

\input{submission-data.tex}

\submissiondate{31 March 2026}
\coveropening{Dear Editor,}
\coverclosing{Best regards,}
\coversignature{Author A, Author B and Author C}

\begin{document}
\makecoverletter

Introductory submission paragraph.

\section{Short Description}
Main description paragraph(s).

\section{Reasons for Publication}
Why the paper fits the journal.

\section{Final Statement}
Any final declaration or closing note.

\section{Research Highlights}
\begin{itemize}
  \item First highlight.
  \item Second highlight.
\end{itemize}
\end{document}
```

### Title page

```tex
\documentclass{editorialcover}

\input{submission-data.tex}

\addauthor{Dr.\ Author A}{author.a@example.com}{1}
\addauthor[Corresponding author]{Dr.\ Author B}{author.b@example.com}{1,2}

\addaffiliation{1}{Department, University, City, Country.}
\addaffiliation{2}{Institute, University, City, Country.}

\begin{document}
\maketitlepage
\end{document}
```

## Notes

- The class is tuned for editorial-looking typography with a Pagella/Palatino-style text face.
- Cover-letter content is written linearly after `\makecoverletter`, and the closing/signature are emitted automatically at the end of the document.
- `\makeeditorialpackage` remains available for a fully declarative flow using `\coversection{...}{...}`.
- `\makecoverletter` and `\maketitlepage` are intended to be used in separate files when submitting distinct documents.
- `\makecoverletterclosing` is still available for the older declarative workflow, but it is no longer needed in the split-file setup.
