\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{editorialcover}[2026/03/31 Editorial cover letter and title page class]

\LoadClass[11pt]{article}

\RequirePackage[a4paper,margin=1in]{geometry}
\RequirePackage{xcolor}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage{microtype}
\RequirePackage{setspace}
\RequirePackage{enumitem}
\RequirePackage{ragged2e}
\RequirePackage{hyperref}
\RequirePackage{iftex}

\definecolor{ELink}{HTML}{1B365D}
\definecolor{ELaccent}{HTML}{355C5B}
\definecolor{ELrule}{HTML}{D9D4CA}
\definecolor{ELtext}{HTML}{24201B}

\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \IfFileExists{newpxtext.sty}{
    \RequirePackage[osf]{newpxtext}
  }{
    \RequirePackage[sc]{mathpazo}
  }
\else
  \RequirePackage{fontspec}
  \setmainfont{TeX Gyre Pagella}
\fi

\hypersetup{
  colorlinks=true,
  linkcolor=ELink,
  urlcolor=ELink
}
\urlstyle{same}

\setlength{\parindent}{0pt}
\setlength{\parskip}{0.75em}
\setstretch{1.08}
\color{ELtext}

\pagestyle{empty}

\newcommand{\EL@date}{\today}
\newcommand{\EL@journal}{}
\newcommand{\EL@articletitle}{}
\newcommand{\EL@opening}{Dear Editor,}
\newcommand{\EL@closing}{Best regards,}
\newcommand{\EL@signature}{}
\newcommand{\EL@submission}{}
\newcommand{\EL@coversections}{}
\newcommand{\EL@highlightitems}{}
\newcommand{\EL@authorrows}{}
\newcommand{\EL@affiliationrows}{}
\newif\ifEL@coverletteractive
\newif\ifEL@coverletterclosed

\NewDocumentCommand{\submissiondate}{m}{\gdef\EL@date{#1}}
\NewDocumentCommand{\journal}{m}{\gdef\EL@journal{#1}}
\NewDocumentCommand{\articleTitle}{m}{\gdef\EL@articletitle{#1}}
\NewDocumentCommand{\coveropening}{m}{\gdef\EL@opening{#1}}
\NewDocumentCommand{\coverclosing}{m}{\gdef\EL@closing{#1}}
\NewDocumentCommand{\coversignature}{m}{\gdef\EL@signature{#1}}
\NewDocumentCommand{\submissionstatement}{+m}{\gdef\EL@submission{#1}}
\NewDocumentCommand{\addhighlight}{+m}{\gappto\EL@highlightitems{\item #1}}
\NewDocumentCommand{\addauthor}{O{} m m m}{\gappto\EL@authorrows{\EL@authorline{#2}{#3}{#4}{#1}}}
\NewDocumentCommand{\addaffiliation}{m+m}{\gappto\EL@affiliationrows{\EL@affiliationline{#1}{#2}}}
\RenewDocumentCommand{\section}{m}{\EL@sectionheading{#1}\ignorespaces}
\NewDocumentCommand{\coversection}{m+m}{\gappto\EL@coversections{\EL@sectionblock{#1}{#2}}}

\newcommand{\EL@folio}{%
  \noindent{\color{ELrule}\rule{0.333\textwidth}{1.2pt}}\par
  \vspace{0.7em}%
}

\newcommand{\EL@displaytitle}[1]{%
  {\fontsize{20}{24}\selectfont\bfseries #1\par}%
}

\newcommand{\EL@rule}{%
  \par\noindent{\color{ELrule}\rule{\textwidth}{0.7pt}}\par
}

\newcommand{\EL@sectionblock}[2]{%
  \EL@sectionheading{#1}%
  \justifying #2\par
}

\newcommand{\EL@sectionheading}[1]{%
  \vspace{0.85em}%
  \noindent{\large\scshape\color{ELaccent} #1}\par
  \vspace{0.2em}%
}

\newcommand{\EL@authorline}[4]{%
  \textbf{#1}\textsuperscript{#3}\par
  \href{mailto:#2}{#2}%
  \ifblank{#4}{}{ \hfill {\footnotesize\scshape #4}}%
  \par\vspace{0.45em}%
}

\newcommand{\EL@affiliationline}[2]{%
  \textsuperscript{#1}\,#2\par\vspace{0.2em}%
}

\newcommand{\makecoverletter}{%
  \global\EL@coverletteractivetrue
  \global\EL@coverletterclosedfalse
  \clearpage
  \thispagestyle{empty}
  \EL@folio
  \EL@displaytitle{Cover Letter}
  \ifblank{\EL@journal}{}{%
    {\itshape Submitted to \EL@journal\par}%
  }
  \vspace{1.15em}
  \begin{flushright}
    \small \EL@date
  \end{flushright}
  \vspace{0.45em}
  {\large\itshape \EL@opening\par}
  \vspace{0.65em}
}

\newcommand{\EL@renderdeclarativecoverletter}{%
  \ifblank{\EL@submission}{}{\justifying \EL@submission\par}
  \ifblank{\EL@coversections}{}{\EL@coversections}
  \ifblank{\EL@highlightitems}{}{%
    \EL@sectionblock{Research Highlights}{%
      \begin{itemize}[leftmargin=1.65em,itemsep=0.4em,topsep=0.35em]
        \EL@highlightitems
      \end{itemize}
    }%
  }
}

\newcommand{\EL@rendercoverletterfooter}{%
  \vspace{0.9em}
  {\EL@closing\par}
  \vspace{1.8em}
  {\scshape \EL@signature\par}
}

\newcommand{\makecoverletterclosing}{%
  \global\EL@coverletterclosedtrue
  \EL@renderdeclarativecoverletter
  \EL@rendercoverletterfooter
  \clearpage
}

\newcommand{\maketitlepage}{%
  \clearpage
  \begingroup
  \thispagestyle{empty}
  \setstretch{1.0}
  \setlength{\parskip}{0.35em}
  \renewcommand{\EL@sectionheading}[1]{%
    \vspace{0.65em}%
    \noindent{\large\scshape\color{ELaccent} ##1\par}%
    \vspace{0.05em}%
  }
  \renewcommand{\EL@authorline}[4]{%
    \textbf{##1}\textsuperscript{##3}\par
    \href{mailto:##2}{##2}\par
    \ifblank{##4}{}{{\footnotesize\scshape\color{ELaccent} ##4\par}}%
    \vspace{0.15em}%
  }
  \renewcommand{\EL@affiliationline}[2]{%
    \textsuperscript{##1}\,##2\par\vspace{0.05em}%
  }
  \EL@folio
  \EL@displaytitle{Title Page}
  \vspace{0.55em}
  \EL@rule
  \vspace{0.45em}
  {\large\scshape\color{ELaccent} Manuscript Title\par}
  \vspace{0.1em}
  {\fontsize{18}{21}\selectfont\bfseries\itshape \EL@articletitle\par}
  \vspace{0.25em}
  \EL@sectionblock{Authors}{\EL@authorrows}
  \vspace{0.1em}
  \EL@sectionblock{Affiliations}{\EL@affiliationrows}
  \vfill
  \EL@rule
  \ifblank{\EL@journal}{}{%
    {\small\itshape Prepared for editorial consideration at \EL@journal\par}%
  }
  \endgroup
  \clearpage
}

\newcommand{\makeeditorialpackage}{%
  \makecoverletter
  \makecoverletterclosing
  \maketitlepage
}

\AtEndDocument{%
  \ifEL@coverletteractive
    \ifEL@coverletterclosed\else
      \EL@rendercoverletterfooter
    \fi
  \fi
}
