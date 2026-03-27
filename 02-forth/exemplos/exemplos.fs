\ Exemplo de função/comando personalizado em Forth
: say-hello ( -- )
  ." Hello, World!" cr 
;

\ Exemplo usando o comando accept para ler uma linha de entrada do usuário
\ pad    - coloca um endereço de buffer na pilha
\ accept - lê o endereço e um tamanho máximo, pede entrada do usuário e 
\          armazena no buffer, retornando o número de caracteres lidos
\ type   - mesmos argumentos de accept, mas imprime o conteúdo do buffer
: echo ( -- )
  ." > "
  pad 80 accept pad swap cr type 
;

\ Exemplo usando o comando key para ler um caracter do usuário.
\ key - lê um caractere do usuário e retorna seu código ASCII na pilha
\       lembramos que 0 = 48 em ASCII, A = 65, a = 97, etc.
: add-numbers ( -- )
  ." a: " key 48 - cr \ Converte o caractere para um número (assumindo entrada de '0' a '9')
  ." b: " key 48 - cr \ Converte o caractere para um número
  + . cr
;

\ ROT13 usando key e emit para ler e escrever caracteres
: rot-13 ( -- )
  key dup emit ."  --> "
  97 - 13 + 26 mod 97 + emit cr recurse
;

rot-13 bye