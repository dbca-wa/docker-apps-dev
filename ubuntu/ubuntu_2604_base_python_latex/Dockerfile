FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu_2604_base_python as builder_base_ubuntu2604_python
MAINTAINER asi@dbca.wa.gov.au

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth

RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y

# Install nodejs
RUN update-ca-certificates
RUN apt-get install --no-install-recommends -y libffi-dev libyaml-dev

# RUN cd /tmp && \
#     wget -q https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
#     tar -xzf install-tl-unx.tar.gz && \
#     cd install-tl-* && \
#     printf '%s\n' \
#       'selected_scheme scheme-small' \
#       'TEXDIR /opt/texlive' \
#       'TEXMFLOCAL /opt/texlive/texmf-local' \
#       'TEXMFSYSCONFIG /opt/texlive/texmf-config' \
#       'TEXMFSYSVAR /opt/texlive/texmf-var' \
#       > texlive.profile && \
#     ./install-tl -profile texlive.profile && \
#     /opt/texlive/bin/*/tlmgr install \
#       latexmk \
#       collection-latexextra \
#       collection-latex \
#       collection-latexrecommended \
#       collection-fontsrecommended \
#       collection-latexextra \
#       collection-langenglish && \      
#       rm -rf /tmp/install-tl*


RUN cd /tmp && \
    wget -q https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    rm install-tl-unx.tar.gz && \
    cd install-tl-* && \
    printf '%s\n' \
      'selected_scheme scheme-small' \
      'TEXDIR /opt/texlive' \
      'TEXMFLOCAL /opt/texlive/texmf-local' \
      'TEXMFSYSCONFIG /opt/texlive/texmf-config' \
      'TEXMFSYSVAR /opt/texlive/texmf-var' \
      > texlive.profile && \
    ./install-tl -profile texlive.profile && \
    /opt/texlive/bin/*/tlmgr update --self && \
        /opt/texlive/bin/*/tlmgr install latexmk && \
        rm -rf /tmp/install-tl*
        
RUN /opt/texlive/bin/*/tlmgr install txfonts
RUN /opt/texlive/bin/*/tlmgr install tabu
RUN /opt/texlive/bin/*/tlmgr install hyphenat
RUN /opt/texlive/bin/*/tlmgr install makecell     



ENV PATH="/opt/texlive/bin/x86_64-linux:${PATH}"

# Make all saved values in \tabu@setcleanup global; fail the build if the patch does not apply
RUN export TABU_STY="$(kpsewhich tabu.sty)" && \
    perl -0pi -e 's{(\\def\\tabu\@setcleanup\s*\{.*?\}% \\tabu\@setcleanup)}{ my $b=$1; $b =~ s/\\edef(\\(?:tabu\@alloc\@save|c\@taburow\@save|tabu\@naturalX\@save))/\\xdef$1/g; $b =~ s/\\let(\\[A-Za-z\@]+\@save)/\\global\\let$1/g; $b }se' "$TABU_STY" && \
    test "$(grep -c 'global.let.*@save\|xdef.*@save' "$TABU_STY")" -ge 16 && \
    echo "tabu patched: $TABU_STY" && \
    sed -i 's/\\edef\\tabu@evr@G/\\xdef\\tabu@evr@G/g' "$TABU_STY" && \
    sed -i 's/\\def\\tabu@evr@G/\\gdef\\tabu@evr@G/g'  "$TABU_STY" && \
    sed -i 's/\\let\\tabu@evr@G/\\global\\let\\tabu@evr@G/g' "$TABU_STY" 
      
# Fail the build if tabu cannot compile a table
RUN mkdir /tmp/tabutest && cd /tmp/tabutest && \
    printf '%s\n' '\documentclass{scrartcl}' '\usepackage{tabu}' '\begin{document}' \
      '\begin{tabu} to \textwidth {X[l] X[r]}' 'a & b \\' '\end{tabu}' '\end{document}' > t.tex && \
    pdflatex -halt-on-error t.tex && cd / && rm -rf /tmp/tabutest

# RUN cd /tmp/tabutest && rm -f t.aux t.log t.pdf && pdflatex -halt-on-error t.tex

RUN which pdflatex && \
    pdflatex --version && \
    latexmk --version
      
