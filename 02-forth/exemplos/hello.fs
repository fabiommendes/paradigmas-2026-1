\ Commentários começam com a barra invertida
\ Este é um programa simples que imprime "Hello, World!" na tela
." Hello, World!" cr bye

\ Vamos destrinchar:
\ ."  - é um comando que imprime uma string literal na tela
\       (note o espaço depois das aspas, ele é necessário para separar o 
\       conteúdo da string do comando. A string termina quando a próxima aspa 
\       é encontrada.)
\ cr  - é um comando que imprime uma nova linha no terminal.
\ bye - encerra a execução do programa, retornando o controle para o sistema 
\       operacional. Se não for usado, o interpretador continuará executando
\       no modo interativo após executar o seu programa.

\ Execute esse código usando o interpretador Forth como em
\   $ gforth hello.fs
