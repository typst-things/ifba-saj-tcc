#import "@preview/codly:1.3.0": *
#show: codly-init.with()

// Seu código aqui
#codly(zebra-fill: none)
#codly(display-name: false)
//#codly(filename: "server.js")

#figure(
  raw(read("example/assets/codigos/server.js"), lang: "js", block: true,),
  caption: [Arquivo externo: main.rs],
  kind: "code",
  supplement: [Código]
)

```python
def somar(a, b):
    return a + b
```